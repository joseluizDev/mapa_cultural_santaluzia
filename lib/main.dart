import 'package:flutter/material.dart';

import 'presentation/pages/home_page.dart';
import 'presentation/themes/app_theme.dart';

void main() {
  runApp(const MapaCulturalApp());
}

class MapaCulturalApp extends StatelessWidget {
  const MapaCulturalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Famosos Locais - Santa Luzia',
      theme: AppTheme.temaClaro,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
