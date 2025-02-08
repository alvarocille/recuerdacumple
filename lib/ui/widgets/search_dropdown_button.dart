import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Widget que representa un botón desplegable para buscar y seleccionar valores.
class SearchDropdownButton extends StatelessWidget {
  /// Etiqueta que se muestra en el botón desplegable.
  final String label;

  /// Valor seleccionado actualmente.
  final int? selectedValue;

  /// Función que se llama cuando cambia el valor seleccionado.
  final ValueChanged<int?> onChanged;

  /// Crea una instancia de [SearchDropdownButton].
  const SearchDropdownButton({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    List<int> items = [];
    List<String> monthNames = [
      AppLocalizations.of(context)?.january ?? 'Enero',
      AppLocalizations.of(context)?.february ?? 'Febrero',
      AppLocalizations.of(context)?.march ?? 'Marzo',
      AppLocalizations.of(context)?.april ?? 'Abril',
      AppLocalizations.of(context)?.may ?? 'Mayo',
      AppLocalizations.of(context)?.june ?? 'Junio',
      AppLocalizations.of(context)?.july ?? 'Julio',
      AppLocalizations.of(context)?.august ?? 'Agosto',
      AppLocalizations.of(context)?.september ?? 'Septiembre',
      AppLocalizations.of(context)?.october ?? 'Octubre',
      AppLocalizations.of(context)?.november ?? 'Noviembre',
      AppLocalizations.of(context)?.december ?? 'Diciembre',
    ];

    if (label == (AppLocalizations.of(context)?.month ?? 'Mes')) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          DropdownButton<int?>(
            hint: Text('${AppLocalizations.of(context)?.selectLabel ?? 'Seleccione'} $label'),
            value: selectedValue,
            items: [
              const DropdownMenuItem<int?>(value: null, child: Text("")),
              ...List.generate(12, (index) => DropdownMenuItem<int?>(
                value: index + 1,
                child: Text(monthNames[index]),
              )),
            ],
            onChanged: onChanged,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
          ),
        ],
      );
    } else if (label == (AppLocalizations.of(context)?.year ?? 'Año')) {
      items = List.generate(DateTime.now().year - 1900 + 1, (index) => DateTime.now().year - index);
    } else {
      items = List.generate(31, (index) => index + 1);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        DropdownButton<int?>(
          hint: Text('${AppLocalizations.of(context)?.selectLabel ?? 'Seleccione'} $label'),
          value: selectedValue,
          items: [
            const DropdownMenuItem<int?>(value: null, child: Text("")),
            ...items.map((e) => DropdownMenuItem<int?>(
              value: e,
              child: Text('$e'),
            )),
          ],
          onChanged: onChanged,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
        ),
      ],
    );
  }
}