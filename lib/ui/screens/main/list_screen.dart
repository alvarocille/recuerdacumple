import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/user_provider.dart';
import '../../viewmodel/main/birthday_list_viewmodel.dart';
import '../../viewmodel/main_screen_viewmodel.dart';
import '../../widgets/search_dropdown_button.dart';

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
            child: Row(
              children: [
                Expanded(
                  child: Consumer<BirthdayListViewModel>(
                    builder: (context, viewModel, child) {
                      return TextField(
                        controller: viewModel.searchController,
                        decoration: InputDecoration(
                          labelText: 'Buscar cumpleañero',
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
                const SizedBox(width: 8),
                Consumer<BirthdayListViewModel>(
                  builder: (context, viewModel, child) {
                    return SearchDropdownButton(
                      label: 'Día',
                      selectedValue: viewModel.selectedDay,
                      onChanged: (value) => viewModel.updateSelectedDay(value),
                    );
                  },
                ),
                const SizedBox(width: 8),
                Consumer<BirthdayListViewModel>(
                  builder: (context, viewModel, child) {
                    return SearchDropdownButton(
                      label: 'Mes',
                      selectedValue: viewModel.selectedMonth,
                      onChanged: (value) => viewModel.updateSelectedMonth(value),
                    );
                  },
                ),
                const SizedBox(width: 8),
                Consumer<BirthdayListViewModel>(
                  builder: (context, viewModel, child) {
                    return SearchDropdownButton(
                      label: 'Año',
                      selectedValue: null,
                      onChanged: (value) => viewModel.updateSelectedYear(value),
                    );
                  },
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    context.read<BirthdayListViewModel>().clearFilters();
                  },
                ),
              ],
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
                                    // Todo: añadir edición de cumpleaños
                                    ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Función editar no disponible. Cree un nuevo cumpleaños y elimine el actual.'),
                                    ),
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

  Future<void> _loadData(BuildContext context, int? userId) async {
    final viewModel = context.read<BirthdayListViewModel>();
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
