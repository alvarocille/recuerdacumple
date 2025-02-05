import 'package:flutter/material.dart';
import 'package:recuerdacumple/ui/widgets/app_drawer.dart';
import 'community_screen.dart';
import 'calendar_screen.dart';
import 'list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const CalendarScreen(),
    const ListScreen(),
    const CommunityScreen(),
  ];

  void _onSectionChoose(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: _screens[_currentIndex], // Muestra la pantalla actual
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onSectionChoose, // Cambia de pantalla sin animación molesta
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
      ),
    );
  }
}