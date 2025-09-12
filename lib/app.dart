import 'package:flutter/material.dart';
import 'package:mapa_cultural_santaluzia/presentation/pages/home_page.dart';
import 'package:mapa_cultural_santaluzia/presentation/themes/app_theme.dart';

class MapaCulturalApp extends StatelessWidget {
  const MapaCulturalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Famosos Locais - Santa Luzia',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
