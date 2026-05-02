import 'package:flutter/material.dart';

import '../../../models/gallery_model.dart';

class GalleryCard extends StatelessWidget {
  final GalleryModel image;

  const GalleryCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (image.isAsset) {
      return Image.asset(
        image.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorPlaceholder();
        },
      );
    } else {
      return Image.network(
        image.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // print yerine debugPrint kullanarak o mavi uyarıyı sildik:
          debugPrint("Resim yükleme hatası: $error");
          return _buildErrorPlaceholder();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildLoadingPlaceholder();
        },
      );
    }
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      color: Colors.grey[900],
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.amber,
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: Colors.grey[900],
      child: const Center(
        child: Icon(Icons.broken_image, color: Colors.white54, size: 40),
      ),
    );
  }
}
