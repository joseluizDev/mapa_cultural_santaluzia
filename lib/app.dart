import 'package:flutter/material.dart';
import 'package:mapa_cultural_santaluzia/core/routes.dart';
import 'package:mapa_cultural_santaluzia/core/routes_with_value_store.dart';
import 'package:mapa_cultural_santaluzia/presentation/themes/app_theme.dart';

class MapaCulturalApp extends StatelessWidget {
  final bool useValueStore;

  const MapaCulturalApp({super.key, this.useValueStore = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Famosos Locais - Santa Luzia',
      theme: AppTheme.lightTheme,
      routerConfig: useValueStore
          ? AppRoutesWithValueStore.router
          : AppRoutes.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
