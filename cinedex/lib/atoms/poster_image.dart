import 'package:flutter/material.dart';
import 'loading_spinner.dart';

class PosterImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;

  const PosterImage({super.key, required this.url, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    const fallback = Center(child: Icon(Icons.movie, size: 40));
    if (url.isEmpty) {
      return SizedBox(width: width, height: height, child: fallback);
    }
    return Image.network(
      url,
      key: ValueKey(url),
      width: width,
      height: height,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : const Center(child: LoadingSpinner()),
      errorBuilder: (context, error, stack) =>
          SizedBox(width: width, height: height, child: fallback),
    );
  }
}
