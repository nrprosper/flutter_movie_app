import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TmdbImage  extends StatelessWidget {
  final String ?imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;

  const TmdbImage({
    super.key,
    this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://image.tmdb.org/t/p/original$imagePath',
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Container(
        color: Colors.grey[300],
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[800],
        child: const Icon(Icons.error_outline, color: Colors.red),
      ),
    );
  }
}
