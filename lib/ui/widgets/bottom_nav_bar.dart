import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Widget que representa la barra de navegación inferior de la aplicación.
class BottomNavBar extends StatelessWidget {
  /// Índice actual seleccionado.
  final int currentIndex;

  /// Función que se llama al seleccionar una sección.
  final Function(int) onSectionChoose;

  /// Crea una instancia de [BottomNavBar].
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onSectionChoose,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onSectionChoose, // Llamamos directamente la función recibida
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_today),
          label: AppLocalizations.of(context)?.calendar ?? 'Calendario',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.list),
          label: AppLocalizations.of(context)?.list ?? 'Lista',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.online_prediction),
          label: AppLocalizations.of(context)?.community ?? 'Comunidad',
        ),
      ],
      backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      type: BottomNavigationBarType.fixed,
    );
  }
}