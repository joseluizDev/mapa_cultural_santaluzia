import 'package:flutter/material.dart';
import 'package:mapa_cultural_santaluzia/core/routes.dart';
import 'package:mapa_cultural_santaluzia/presentation/themes/app_theme.dart';

class MapaCulturalApp extends StatelessWidget {
  const MapaCulturalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Famosos Locais - Santa Luzia',
      theme: AppTheme.lightTheme,
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
