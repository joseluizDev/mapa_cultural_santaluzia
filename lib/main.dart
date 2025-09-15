import 'package:flutter/material.dart';
import 'package:mapa_cultural_santaluzia/app.dart';
import 'package:mapa_cultural_santaluzia/core/di/service_locator.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Configure dependency injection
  await configureDependencies();

  // Set this to true to use ValueNotifier pattern
  const useValueStore = true;

  runApp(const MapaCulturalApp(useValueStore: useValueStore));
}
