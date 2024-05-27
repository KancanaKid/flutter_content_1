import 'package:flutter/material.dart';

class CenterLayout extends StatelessWidget {
  const CenterLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contoh Center Layout"),
        foregroundColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const Center(
        child: Text(
          "Layout ini menggunakan Center",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
