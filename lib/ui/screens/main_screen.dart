import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recuerdacumple/ui/widgets/app_drawer.dart';
import '../viewmodel/main_screen_viewmodel.dart';

/// Pantalla principal de la aplicación.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainScreenViewModel = Provider.of<MainScreenViewModel>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final translatedTitles = [
        AppLocalizations.of(context)?.calendar ?? 'Calendario',
        AppLocalizations.of(context)?.birthdays ?? 'Cumpleaños',
        AppLocalizations.of(context)?.community ?? 'Comunidad',
      ];
      mainScreenViewModel.setTitles(translatedTitles);
    });

    return Scaffold(
      appBar: AppBar(
        title: Consumer<MainScreenViewModel>(
          builder: (context, viewModel, child) {
            return Text(viewModel.currentTitle);
          },
        ),
        centerTitle: true,
        actions: [
          Consumer<MainScreenViewModel>(
            builder: (context, viewModel, child) {
              return viewModel.currentIndex != 2
                  ? IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, '/add');
                },
              )
                  : const SizedBox();
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Consumer<MainScreenViewModel>(
        builder: (context, viewModel, child) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return viewModel.screens[viewModel.currentIndex];
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<MainScreenViewModel>(
        builder: (context, viewModel, child) {
          return BottomNavigationBar(
            currentIndex: viewModel.currentIndex,
            onTap: (index) => viewModel.onSectionChoose(index),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.calendar_today),
                label: viewModel.translatedTitles[0],
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.cake),
                label: viewModel.translatedTitles[1],
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.group),
                label: viewModel.translatedTitles[2],
              ),
            ],
            backgroundColor: Theme.of(context).cardColor,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            unselectedItemColor: Theme.of(context).unselectedWidgetColor,
          );
        },
      ),
    );
  }
}