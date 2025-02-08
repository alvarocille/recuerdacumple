import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../provider/user_provider.dart';
import '../../viewmodel/main/birthday_list_viewmodel.dart';
import '../../viewmodel/main_screen_viewmodel.dart';
import '../../widgets/search_dropdown_button.dart';
import '../utilities/edit_birthday_dialog.dart';

/// Pantalla que muestra una lista filtrada con los cumpleaños a recordar del usuario.
class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mainViewModel = context.read<MainScreenViewModel>();
      context.read<BirthdayListViewModel>().setDate(mainViewModel.selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final int? userId = user?.id;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth > 600 ? 600 : constraints.maxWidth - 40,
                      child: Consumer<BirthdayListViewModel>(
                        builder: (context, viewModel, child) {
                          return TextField(
                            controller: viewModel.searchController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)?.searchBirthdayPerson ?? 'Buscar cumpleañero',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (query) {
                              viewModel.filterBirthdays(
                                name: query,
                                day: viewModel.selectedDay,
                                month: viewModel.selectedMonth,
                                year: viewModel.selectedYear,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth > 600 ? 150 : (constraints.maxWidth - 64) / 4, // Ajusta el tamaño según el espacio disponible
                      child: Consumer<BirthdayListViewModel>(
                        builder: (context, viewModel, child) {
                          return SearchDropdownButton(
                            label: AppLocalizations.of(context)?.day ?? 'Día',
                            selectedValue: viewModel.selectedDay,
                            onChanged: (value) => viewModel.updateSelectedDay(value),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth > 600 ? 150 : (constraints.maxWidth - 64) / 4, // Ajusta el tamaño según el espacio disponible
                      child: Consumer<BirthdayListViewModel>(
                        builder: (context, viewModel, child) {
                          return SearchDropdownButton(
                            label: AppLocalizations.of(context)?.month ?? 'Mes',
                            selectedValue: viewModel.selectedMonth,
                            onChanged: (value) => viewModel.updateSelectedMonth(value),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth > 600 ? 150 : (constraints.maxWidth - 64) / 4, // Ajusta el tamaño según el espacio disponible
                      child: Consumer<BirthdayListViewModel>(
                        builder: (context, viewModel, child) {
                          return SearchDropdownButton(
                            label: AppLocalizations.of(context)?.year ?? 'Año',
                            selectedValue: viewModel.selectedYear,
                            onChanged: (value) => viewModel.updateSelectedYear(value),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth > 600 ? 48 : (constraints.maxWidth - 64) / 4, // Ajusta el tamaño del IconButton
                      child: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          context.read<BirthdayListViewModel>().clearFilters();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<void>(
              future: _loadData(context, userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Consumer<BirthdayListViewModel>(
                    builder: (context, viewModel, child) {
                      return ListView.builder(
                        itemCount: viewModel.filteredBirthdays.length,
                        itemBuilder: (context, index) {
                          final birthday = viewModel.filteredBirthdays[index];
                          return ListTile(
                            title: Text(birthday.name),
                            subtitle: Text(
                              '${birthday.date.day}/${birthday.date.month}/${birthday.date.year}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => EditBirthdayDialog(birthday: birthday),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    context.read<BirthdayListViewModel>().deleteBirthday(birthday);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Metodo para cargar los cumpleaños en la lista y filtrarlos si es necesario
  Future<void> _loadData(BuildContext context, int? userId) async {
    final viewModel = context.read<BirthdayListViewModel>();
    viewModel.clearFilters();
    viewModel.birthdays.clear();
    await viewModel.loadFriendsBirthdays(userId!);
    await viewModel.loadUserEvents(userId);

    context.read<BirthdayListViewModel>().filterBirthdays(
      name: viewModel.searchController.text,
      day: viewModel.selectedDay,
      month: viewModel.selectedMonth,
      year: viewModel.selectedYear,
    );
  }
}