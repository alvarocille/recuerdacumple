import 'package:flutter/material.dart';

class SearchDropdownButton extends StatelessWidget {
  final String label;
  final int? selectedValue;
  final ValueChanged<int?> onChanged;

  const SearchDropdownButton({super.key,
    required this.label,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    List<int> items = [];
    List<String> monthNames = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio',
      'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];

    if (label == 'Mes') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          DropdownButton<int?>(
            hint: Text('Seleccione $label'),
            value: selectedValue,
            items: [
              DropdownMenuItem<int?>(value: null, child: Text("")),
              ...List.generate(12, (index) => DropdownMenuItem<int?>(
                value: index + 1,
                child: Text(monthNames[index]),
              )),
            ],
            onChanged: onChanged,
            isExpanded: false,
            icon: const Icon(Icons.arrow_drop_down),
          ),
        ],
      );
    } else if (label == 'Año') {
      items = List.generate(DateTime.now().year - 1900 + 1, (index) => DateTime.now().year - index);
    } else {
      items = List.generate(31, (index) => index + 1);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        DropdownButton<int?>(
          hint: Text('Seleccione $label'),
          value: selectedValue,
          items: [
            DropdownMenuItem<int?>(value: null, child: Text("")),
            ...items.map((e) => DropdownMenuItem<int?>(
              value: e,
              child: Text('$e'),
            )),
          ],
          onChanged: onChanged,
          isExpanded: false,
          icon: const Icon(Icons.arrow_drop_down),
        ),
      ],
    );
  }
}
