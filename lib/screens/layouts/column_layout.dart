import 'package:flutter/material.dart';

class ColumnLayout extends StatelessWidget {
  const ColumnLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contoh Column Layout"),
        foregroundColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("widget text 1", style: TextStyle(fontSize: 20.0)),
            Text("widget text 2", style: TextStyle(fontSize: 20.0)),
            Text("widget text 3", style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
