import 'dart:async';

import 'package:flutter/material.dart';

class MarqueeGallery extends StatefulWidget {
  final List<dynamic> images; // List of GalleryModel or String
  final Widget Function(dynamic image) itemBuilder;

  const MarqueeGallery({
    super.key,
    required this.images,
    required this.itemBuilder,
  });

  @override
  State<MarqueeGallery> createState() => _MarqueeGalleryState();
}

class _MarqueeGalleryState extends State<MarqueeGallery> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage =
      1000; // Starting at a high index to simulate infinite scrolling

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.75, // Adjust to show parts of adjacent images
    );

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, index) {
        final item = widget.images[index % widget.images.length];

        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 1.0;
            if (_pageController.position.hasContentDimensions) {
              value = (_pageController.page! - index);
              // Scale effect: focused item grows while others shrink (20% difference)
              value = (1 - (value.abs() * 0.20)).clamp(0.0, 1.0);
            }
            return Center(
              child: Transform.scale(
                scale: value,
                child: child,
              ),
            );
          },
          child: widget.itemBuilder(item),
        );
      },
    );
  }
}
