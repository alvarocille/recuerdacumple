import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/main/calendar_viewmodel.dart';
import '../../../provider/user_provider.dart';
import '../../viewmodel/main_screen_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Pantalla de calendario.
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = CalendarViewModel();
        viewModel.loadUserBirthdays(user?.id ?? 0);
        return viewModel;
      },
      child: Scaffold(
        body: Consumer<CalendarViewModel>(
          builder: (context, calendarViewModel, child) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return MonthView(
                    controller: calendarViewModel.eventController,
                    cellAspectRatio: constraints.maxWidth < 600 ? 0.8 : 1.4,
                    showBorder: true,
                    borderColor: Theme.of(context).dividerColor,
                    onCellTap: (date, events) {
                      context.read<MainScreenViewModel>().onSectionChoose(
                        1,
                        date: events,
                      );
                    },
                    headerStyle: HeaderStyle(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      headerMargin: const EdgeInsets.all(8.0),
                      headerTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    weekDayBuilder: (day) {
                      List<String> weekDays = _getWeekDays(context);
                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                        ),
                        child: Center(
                          child: Text(
                            weekDays[(day - 1) % 7],
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      );
                    },
                    startDay: _getStartDay(context),
                    cellBuilder: (date, events, isToday, isInMonth, isSelected) {
                      final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
                      return Container(
                        decoration: BoxDecoration(
                          color: isToday ? Colors.red.withOpacity(0.1) : null,
                          border: Border.all(
                            color: isToday ? Colors.red : Theme.of(context).dividerColor,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                color: isToday ? Colors.red : textColor,
                                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            if (events.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.only(top: 4),
                                child: Column(
                                  children: events.map((event) => Text(
                                    event.title,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: event.color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  )).toList(),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  List<String> _getWeekDays(BuildContext context) {
    return [
      AppLocalizations.of(context)?.tuesday ?? 'M',
      AppLocalizations.of(context)?.wednesday ?? 'X',
      AppLocalizations.of(context)?.thursday ?? 'J',
      AppLocalizations.of(context)?.friday ?? 'V',
      AppLocalizations.of(context)?.saturday ?? 'S',
      AppLocalizations.of(context)?.sunday ?? 'D',
      AppLocalizations.of(context)?.monday ?? 'L'
    ];
  }

  WeekDays _getStartDay(BuildContext context) {
    String locale = AppLocalizations.of(context)!.localeName;
    if (locale == 'en' || locale == 'zh') {
      return WeekDays.sunday;
    } else {
      return WeekDays.monday;
    }
  }
}