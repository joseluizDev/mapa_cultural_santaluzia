import 'package:flutter/material.dart';

class AppColors {
  static const Color vermelhoCultural = Color(0xFFc63122);
  static const Color azulCultural = Color(0xFF115a91);
  static const Color verdeBrasileiro = Color(0xFF447832);
  static const Color creme = Color(0xFFf3e2c6);

  static const Color gray50 = Color(0xFFf9fafb);
  static const Color gray100 = Color(0xFFf3f4f6);
  static const Color gray500 = Color(0xFF6b7280);
  static const Color gray900 = Color(0xFF111827);

  static const LinearGradient gradientePrimario = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [vermelhoCultural, azulCultural],
    stops: [0.0, 1.0],
  );

  static const LinearGradient gradienteSecundario = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [azulCultural, verdeBrasileiro],
    stops: [0.0, 1.0],
  );

  static const LinearGradient gradienteQuente = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [creme, Color(0xFFfceeea)],
    stops: [0.0, 1.0],
  );

  static const Color branco = Color(0xFFFFFFFF);
  static const Color pretoPrimario = gray900;
  static const Color cinzaEscuro = Color(0xFF424242);
  static const Color cinzaMedio = gray500;
  static const Color cinzaClaro = gray100;
  static const Color fundoClaro = gray50;

  static const Color sucesso = Color(0xFF4CAF50);
  static const Color aviso = Color(0xFFFF9800);
  static const Color erro = Color(0xFFF44336);
  static const Color informacao = azulCultural;

  static const Color textoPrimario = pretoPrimario;
  static const Color textoSecundario = cinzaMedio;
  static const Color textoBranco = branco;

  static const Color fundoCard = branco;
  static const Color fundoCardGlassmorphism = Color(0xE6f5e3c7);

  static const Color sombraCard = Color(0x1A000000);
  static const Color bordaCard = cinzaClaro;

  AppColors._();
}

class AppShadows {
  static const List<BoxShadow> sombraCard = [
    BoxShadow(
      color: AppColors.sombraCard,
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> sombraElevada = [
    BoxShadow(
      color: AppColors.sombraCard,
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];

  AppShadows._();
}
