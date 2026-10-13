import 'package:flutter/material.dart';
import '../atoms/cine_text.dart';
import '../atoms/loading_spinner.dart';

class LoadingMessage extends StatelessWidget {
  final String text;

  const LoadingMessage(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LoadingSpinner(),
          const SizedBox(height: 12),
          CineText(text),
        ],
      ),
    );
  }
}
