import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/user_provider.dart';
import '../../viewmodel/main/community_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Pantalla de comunidad para agregar amigos y ver el código del usuario.
class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCode = context.watch<UserProvider>().user?.code;

    return ChangeNotifierProvider(
      create: (_) => CommunityViewModel(),
      child: Consumer<CommunityViewModel>(
        builder: (context, communityViewModel, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            communityViewModel.updateFriendCode(userCode!);
          });

          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: communityViewModel.formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: communityViewModel.friendCodeController,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)?.enterFriendCode ?? 'Introduce el código de tu amigo',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: communityViewModel.friendCodeController.clear,
                                ),
                              ),
                              validator: (value) => communityViewModel.validateFriendCode(context, value),
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () => communityViewModel.submitForm(context),
                              child: Text(AppLocalizations.of(context)?.send ?? 'Enviar'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Card(
                        color: Theme.of(context).cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)?.yourFriendCode ?? 'Tu código de amigo:',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 10.0),
                              SelectableText(
                                communityViewModel.myFriendCode,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              ElevatedButton.icon(
                                onPressed: () {
                                  communityViewModel.shareFriendCode(context);
                                },
                                icon: const Icon(Icons.share),
                                label: Text(AppLocalizations.of(context)?.shareCode ?? 'Compartir código'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
