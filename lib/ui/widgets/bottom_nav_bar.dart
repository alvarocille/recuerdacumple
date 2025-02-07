import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onSectionChoose;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onSectionChoose,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onSectionChoose, // Llamamos directamente la función recibida
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
          icon: Icon(Icons.online_prediction),
          label: 'Comunidad',
        ),
      ],
    );
  }
}