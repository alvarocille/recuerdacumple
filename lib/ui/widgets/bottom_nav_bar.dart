import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _onSectionChoose(BuildContext context, int index) {
    switch (index) {
      case 0:
      // Navegar a la pantalla del calendario
        Navigator.pushReplacementNamed(context, '/calendar');
        break;
      case 1:
      // Navegar a la pantalla de lista
        Navigator.pushReplacementNamed(context, '/list');
        break;
      case 2:
      // Navegar a la pantalla de amigos
        Navigator.pushReplacementNamed(context, '/friends');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onSectionChoose(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Calendario',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Lista',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pets),
          label: 'Amigos',
        ),
      ],
    );
  }
}