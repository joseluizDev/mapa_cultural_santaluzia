import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final List<Widget>? acoes;
  final bool mostrarVoltar;

  const GradientAppBar({
    super.key,
    required this.titulo,
    this.acoes,
    this.mostrarVoltar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.gradientePrimario),
      child: AppBar(
        title: Text(
          titulo,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textoBranco,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: mostrarVoltar,
        actions: acoes,
        iconTheme: const IconThemeData(color: AppColors.textoBranco),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class NavigationButton extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final bool ativo;

  const NavigationButton({
    super.key,
    required this.texto,
    this.onPressed,
    this.ativo = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: ativo
            ? AppColors.textoBranco
            : AppColors.textoBranco.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.espacamentoMedio,
          vertical: AppDimensions.espacamentoPequeno,
        ),
      ),
      child: Text(
        texto,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: ativo
              ? AppColors.textoBranco
              : AppColors.textoBranco.withOpacity(0.7),
          fontWeight: ativo ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}
