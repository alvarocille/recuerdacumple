import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/main/calendar_viewmodel.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalendarViewModel(),  // Proveer el ViewModel
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Consumer<CalendarViewModel>(
                builder: (context, calendarViewModel, child) {
                  return MonthView(
                    cellAspectRatio: 1.4,
                    onCellTap: (date, events) {
                      // Agregar evento al seleccionar una fecha
                      calendarViewModel.addEvent('Evento en $date');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Seleccionaste: $date')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
