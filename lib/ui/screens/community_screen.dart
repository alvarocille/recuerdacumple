import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  CommunityScreenState createState() => CommunityScreenState();
}

class CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController _friendCodeController = TextEditingController();
  final String _myFriendCode = "ABC123XYZ"; // Simulación del código del usuario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunidad'),
        centerTitle: true,
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu),
          onSelected: (String value) {
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo para introducir código de amigo
            TextFormField(
              controller: _friendCodeController,
              decoration: InputDecoration(
                labelText: 'Introduce el código de tu amigo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _friendCodeController.clear();
                  },
                ),
              ),
            ),
            const SizedBox(height: 24.0),

            // Muestra el código de amigo del usuario
            Card(
              color: Colors.purple.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Tu código de amigo:',
                      style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    SelectableText(
                      _myFriendCode,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton.icon(
                      onPressed: () {
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Compartir código'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
