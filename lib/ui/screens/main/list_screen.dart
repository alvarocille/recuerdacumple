import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/user_provider.dart';
import '../../viewmodel/main/birthday_list_viewmodel.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final int? userId = user?.id;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar Cumpleaños o Eventos',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (query) {
                context.read<BirthdayListViewModel>().filterBirthdays(query);
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<void>(
              future: _loadData(context, userId!), // Llamada al Future
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
                            subtitle: Text('${birthday.date.day}/${birthday.date.month}/${birthday.date.year}'),
                              onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Seleccionaste a ${birthday.name}')),
                              );
                            },
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

  Future<void> _loadData(BuildContext context, int userId) async {
    final viewModel = context.read<BirthdayListViewModel>();
    await viewModel.loadFriendsBirthdays(userId);
    await viewModel.loadUserEvents(userId);
  }
}
