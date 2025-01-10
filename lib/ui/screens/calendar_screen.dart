import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _selectedIndex = 0; // Variable para almacenar el índice seleccionado

  // Método para manejar la navegación al seleccionar un ítem del BottomNavigationBar
  void _onSectionChoose(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (_selectedIndex) {
      case 0:
        // Navegar a la pantalla del calendario
        Navigator.pushNamed(context, '/calendar');
        break;
      case 1:
        // Navegar a la pantalla de lista
        Navigator.pushNamed(context, '/list');
        break;
      case 2:
        // Navegar a la pantalla de amigos
        Navigator.pushNamed(context, '/friends');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        centerTitle: true,
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu), // Menú de hamburguesa
          onSelected: (String value) {
            // Manejar la acción seleccionada
            if (value == 'Configuración') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Abrir Configuración')),
              );
            } else if (value == 'Perfil') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Abrir Perfil')),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return const [
              PopupMenuItem<String>(
                value: 'Configuración',
                child: Text('Configuración'),
              ),
              PopupMenuItem<String>(
                value: 'Perfil',
                child: Text('Perfil'),
              ),
            ];
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navegar a la pantalla de formulario para agregar cumpleaños
              Navigator.pushNamed(context, '/add');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MonthView(
              cellAspectRatio: 1.4,
              onCellTap: (date, events) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Seleccionaste: $date')),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Establece el índice seleccionado
        onTap: _onSectionChoose, // Maneja el cambio de pantalla al pulsar los ítems
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
            icon: Icon(Icons.language),
            label: 'Amigos',
          ),
        ],
      ),
    );
  }
}
