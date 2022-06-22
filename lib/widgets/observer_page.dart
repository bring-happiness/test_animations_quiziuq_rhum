import 'package:flutter/material.dart';

class ObserverPage extends StatelessWidget {
  const ObserverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Center(
        child: Text(
          'Tu es en mode observateur !',
        ),
      ),
    );
  }
}