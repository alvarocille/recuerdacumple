import 'package:flutter/material.dart';

/// Widget que representa una tarjeta de configuración en la aplicación.
class SettingsCard extends StatelessWidget {
  /// Título de la tarjeta de configuración.
  final String title;

  /// Opción de configuración representada como un widget.
  final Widget option;

  /// Crea una instancia de [SettingsCard].
  const SettingsCard({
    super.key,
    required this.title,
    required this.option,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor, // Color de la tarjeta según el tema
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            option,
          ],
        ),
      ),
    );
  }
}
