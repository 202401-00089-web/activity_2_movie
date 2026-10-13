import 'package:flutter/material.dart';

// Shared layout for every screen: app bar with a title + a body slot.
class ScreenTemplate extends StatelessWidget {
  final String title;
  final Widget body;

  const ScreenTemplate({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(child: body),
    );
  }
}
