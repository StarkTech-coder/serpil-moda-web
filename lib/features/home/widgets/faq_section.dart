// widgets/faq_section.dart
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart'; // AppTheme'i tanıması için

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          const Text("SIKÇA SORULAN SORULAR",
              style: TextStyle(color: AppTheme.gold, letterSpacing: 3)),
          const SizedBox(height: 20),
          _buildFAQTile("Özel dikim ne kadar sürer?",
              "Tasarımın karmaşıklığına göre 2-4 hafta arası sürmektedir."),
          _buildFAQTile("Tadilat yapıyor musunuz?",
              "Evet, her türlü abiye ve gelinlik tadilatı uzman ellerde yapılmaktadır."),
        ],
      ),
    );
  }

  Widget _buildFAQTile(String title, String content) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(content, style: const TextStyle(color: Colors.white70)),
        ),
      ],
    );
  }
}
