import 'package:flutter/material.dart';

class CineText extends StatelessWidget {
  final String text;
  final double size;
  final bool bold;
  final Color? color;
  final TextAlign align;
  final int? maxLines;

  const CineText(
    this.text, {
    super.key,
    this.size = 16,
    this.bold = false,
    this.color,
    this.align = TextAlign.start,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: size,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
    );
  }
}
