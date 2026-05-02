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
          // Başlık
          const Text(
            "ÖZEL TASARIM KOLEKSİYONU",
            style: TextStyle(
              color: AppTheme.gold,
              fontSize: 13,
              letterSpacing: 5,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(),

          const SizedBox(height: 50),

          // Vitrin Bölümü
          SizedBox(
            height:
                600, // Yüksekliği biraz artırdım (Gelinlikler için ideal boy)
            child: galleryAsync.when(
              data: (images) {
                if (images.isEmpty) return const SizedBox.shrink();

                return MarqueeGallery(
                  images: images,
                  itemBuilder: (image) => Container(
                    width: 400, // Genişliği 400 yaparak "orta kıvamı" yakaladık
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
                      // AspectRatio veya doğrudan GalleryCard
                      child: GalleryCard(image: image),
                    ),
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppTheme.gold),
              ),
              error: (e, _) => Center(child: Text("Hata: $e")),
            ),
          ),
        ],
      ),
    );
  }
}
