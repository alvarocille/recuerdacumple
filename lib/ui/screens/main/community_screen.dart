import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/main/community_viewmodel.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommunityViewModel(),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<CommunityViewModel>(
                builder: (context, communityViewModel, child) {
                  return TextFormField(
                    controller: communityViewModel.friendCodeController,
                    decoration: InputDecoration(
                      labelText: 'Introduce el código de tu amigo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: communityViewModel.friendCodeController.clear,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24.0),
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
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Consumer<CommunityViewModel>(
                        builder: (context, communityViewModel, child) {
                          return SelectableText(
                            communityViewModel.myFriendCode,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<CommunityViewModel>().shareFriendCode();
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
      ),
    );
  }
}