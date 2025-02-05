import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard(
      {super.key,
        required this.title,
        required this.option
      });

  final String title;
  final Widget option;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(title),
          option
        ],
      ),
    );
  }
}