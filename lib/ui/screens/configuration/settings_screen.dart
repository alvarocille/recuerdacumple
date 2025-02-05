import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/font_size_viewmodel.dart';
import '../../viewmodel/language_viewmodel.dart';
import '../../viewmodel/theme_viewmodel.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/settings_card.dart';

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
        title: Text("Ajustes"),
      ),
      body: GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          maxCrossAxisExtent: 600,
          mainAxisExtent: 120,
        ),
        children: [
          SettingsCard(
              title: "Modo oscuro",
              option: Switch(
                value: themeVM.isDarkTheme,
                onChanged: (value) =>
                    context.read<ThemeViewModel>().toggleDarkTheme(),
              )
          ),
          SettingsCard(
              title: "Idioma",
              option: DropdownMenu<String>(
                initialSelection: languageVM.selectedLanguage,
                dropdownMenuEntries: languageVM.languages.entries.map((entry) {
                  return DropdownMenuEntry<String>(
                      value: entry.key, label: entry.value);
                  }).toList(),
                onSelected: (value) {
                  context.read<LanguageViewModel>().changeLanguage(value!);
                  },
              ),
          ),
          SettingsCard(
            title: "Tamaño del texto",
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
      ),
    );
  }
}
