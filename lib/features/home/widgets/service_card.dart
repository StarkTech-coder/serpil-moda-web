import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';
import '../../../models/service_model.dart';

class ServiceCard extends StatefulWidget {
  final ServiceModel service;
  const ServiceCard({super.key, required this.service});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  // Track hover state for interactive UI effects
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // Toggle hover state when mouse enters or leaves the region
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: 400.ms,
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          // Highlight border with gold color when hovered
          border: Border.all(
            color: isHovered ? AppTheme.gold : Colors.transparent,
            width: 1,
          ),
          // Apply a subtle golden glow effect on hover
          boxShadow: [
            if (isHovered)
              BoxShadow(
                color: AppTheme.gold.withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: 2,
              )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section with a backup icon in case of network failure
            Expanded(
              child: Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(color: Colors.black12),
                child: Image.network(
                  widget.service.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.brush, color: AppTheme.gold, size: 40),
                  ),
                ),
              ),
            ),
            // Service details: Title and a short description
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.service.title.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: AppTheme.gold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.service.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.1); // Smooth entrance animation
  }
}
