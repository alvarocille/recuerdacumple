import 'package:flutter/material.dart';
import '/models/birthday.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Birthday> birthdays = [
    Birthday("Juan Pérez", DateTime(2025, 5, 12)),
    Birthday("Ana García", DateTime(2025, 6, 3)),
    Birthday("Carlos López", DateTime(2025, 7, 25)),
    // Agrega más cumpleaños aquí
  ];

  List<Birthday> filteredBirthdays = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredBirthdays = birthdays; // Inicializamos con todos los cumpleaños
  }

  void _filterBirthdays(String query) {
    setState(() {
      searchQuery = query;
      filteredBirthdays = birthdays
          .where((birthday) =>
              birthday.name.toLowerCase().contains(query.toLowerCase()) ||
              birthday.date.toString().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cumpleaños'),
        centerTitle: true,
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu),
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
              Navigator.pushNamed(context, '/add');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar Cumpleaños',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: _filterBirthdays,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredBirthdays.length,
              itemBuilder: (context, index) {
                final birthday = filteredBirthdays[index];
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
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
