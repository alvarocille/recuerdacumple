import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recuerdacumple/ui/widgets/app_drawer.dart';
import 'package:recuerdacumple/ui/widgets/bottom_nav_bar.dart';
import 'package:recuerdacumple/ui/viewmodel/main_screen_viewmodel.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainScreenViewModel(), // Proveer el ViewModel
      child: Scaffold(
        drawer: const AppDrawer(),
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
                    : const SizedBox(); // No muestra el botón de añadir si estamos en la pantalla de Comunidad
              },
            ),
          ],
        ),
        body: Consumer<MainScreenViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.screens[viewModel.currentIndex];
          },
        ),
        bottomNavigationBar: Consumer<MainScreenViewModel>(
          builder: (context, viewModel, child) {
            return BottomNavBar(
              currentIndex: viewModel.currentIndex,
              onSectionChoose: viewModel.onSectionChoose,
            );
          },
        ),
      ),
    );
  }
}