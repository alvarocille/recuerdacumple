import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/main/calendar_viewmodel.dart';
import '../../../provider/user_provider.dart';
import '../../viewmodel/main_screen_viewmodel.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = CalendarViewModel();
        viewModel.loadUserBirthdays(user?.id ?? 0); // Cargar cumpleaños
        return viewModel;
      },
      child: Scaffold(
        body: Consumer<CalendarViewModel>(
          builder: (context, calendarViewModel, child) {
            return MonthView(
              controller: calendarViewModel.eventController,
              cellAspectRatio: 1.4,
              onCellTap: (date, events) {
                context.read<MainScreenViewModel>().onSectionChoose(
                  1,
                  date: events,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
