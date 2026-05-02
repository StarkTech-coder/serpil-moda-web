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
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: 400.ms,
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          border: Border.all(
            color: isHovered ? AppTheme.gold : Colors.transparent,
            width: 1,
          ),
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
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1);
  }
}
