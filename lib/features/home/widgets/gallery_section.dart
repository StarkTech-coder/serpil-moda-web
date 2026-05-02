import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../provider/gallery_provider.dart';
import 'gallery_card.dart';
import 'marquee_gallery.dart';

class GallerySection extends ConsumerWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final galleryAsync = ref.watch(galleryStreamProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: [
          // Section Title
          const Text(
            "EXCLUSIVE DESIGN COLLECTION",
            style: TextStyle(
              color: AppTheme.gold,
              fontSize: 13,
              letterSpacing: 5,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(),

          const SizedBox(height: 50),

          // Showcase Section
          SizedBox(
            height: 600, // Optimized height for vertical fashion/dress displays
            child: galleryAsync.when(
              data: (images) {
                if (images.isEmpty) return const SizedBox.shrink();

                return MarqueeGallery(
                  images: images,
                  itemBuilder: (image) => Container(
                    width: 400, // Balanced width for card items
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          blurRadius: 25,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      // Rendering individual GalleryCard within the marquee
                      child: GalleryCard(image: image),
                    ),
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppTheme.gold),
              ),
              error: (e, _) => Center(
                child: Text(
                  "Error loading gallery: $e",
                  style: const TextStyle(color: Colors.white54),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
