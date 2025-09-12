import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/colors.dart';

class AppTheme {
  static ThemeData get temaClaro {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.azulCultural,
        brightness: Brightness.light,
        primary: AppColors.azulCultural,
        secondary: AppColors.vermelhoCultural,
      ),
      textTheme: _textoTema,
      appBarTheme: _appBarTema,
      elevatedButtonTheme: _botaoElevadoTema,
      cardTheme: CardThemeData(
        color: AppColors.fundoCard,
        elevation: 0,
        shadowColor: AppColors.sombraCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.bordaCard, width: 1),
        ),
      ),
      scaffoldBackgroundColor: AppColors.fundoClaro,
    );
  }

  static TextTheme get _textoTema {
    return TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: AppColors.textoPrimario,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: AppColors.textoPrimario,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: AppColors.textoPrimario,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.textoPrimario,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textoPrimario,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textoPrimario,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppColors.textoPrimario,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textoPrimario,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textoPrimario,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textoPrimario,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textoPrimario,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textoSecundario,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textoPrimario,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textoPrimario,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textoSecundario,
      ),
    );
  }

  static AppBarTheme get _appBarTema {
    return AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textoBranco,
      ),
      iconTheme: const IconThemeData(color: AppColors.textoBranco),
    );
  }

  static ElevatedButtonThemeData get _botaoElevadoTema {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.azulCultural,
        foregroundColor: AppColors.textoBranco,
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  AppTheme._(); // Construtor privado para impedir instanciação
}
