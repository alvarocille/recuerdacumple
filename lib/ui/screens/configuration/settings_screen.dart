import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/configuration/font_size_viewmodel.dart';
import '../../viewmodel/configuration/language_viewmodel.dart';
import '../../viewmodel/configuration/theme_viewmodel.dart';
import '../../widgets/settings_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Asegúrate de importar AppLocalizations

/// Pantalla de configuración de la aplicación.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVM = context.watch<ThemeViewModel>();
    final languageVM = context.watch<LanguageViewModel>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)?.settings ?? 'Ajustes'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GridView(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: constraints.maxWidth < 600 ? 1 : 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 3,
            ),
            children: [
              SettingsCard(
                title: AppLocalizations.of(context)?.darkMode ?? 'Modo oscuro',
                option: Switch(
                  value: themeVM.isDarkTheme,
                  onChanged: (value) => context.read<ThemeViewModel>().toggleDarkTheme(),
                ),
              ),
              SettingsCard(
                title: AppLocalizations.of(context)?.language ?? 'Idioma',
                option: DropdownButton<String>(
                  value: languageVM.selectedLanguage,
                  items: languageVM.languages.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    context.read<LanguageViewModel>().changeLanguage(value!);
                  },
                ),
              ),
              SettingsCard(
                title: AppLocalizations.of(context)?.textSize ?? 'Tamaño del texto',
                option: Slider(
                  divisions: 6,
                  min: 0.8,
                  max: 2,
                  value: context.watch<FontSizeViewModel>().fontSizeFactor,
                  onChanged: (value) {
                    context.read<FontSizeViewModel>().fontSizeFactor = value;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}