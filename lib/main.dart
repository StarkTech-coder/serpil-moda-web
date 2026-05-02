import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/home/view/home_screen.dart';
import 'firebase_options.dart'; // flutterfire configure tarafından oluşturulan dosya

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase'i yeni oluşturduğumuz options ile başlatıyoruz
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: SerpilModaApp(),
    ),
  );
}

class SerpilModaApp extends StatelessWidget {
  const SerpilModaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serpil Moda Evi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.luxuryTheme,
      home: const HomeScreen(),
    );
  }
}
