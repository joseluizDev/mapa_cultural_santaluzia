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
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: AppBar(
        title: Text(
          titulo,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.whiteText,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: mostrarVoltar,
        actions: acoes,
        iconTheme: const IconThemeData(color: AppColors.whiteText),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class NavigationButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool active;

  const NavigationButton({
    super.key,
    required this.text,
    this.onPressed,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: active
            ? AppColors.whiteText
            : AppColors.whiteText.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.mediumSpacing,
          vertical: AppDimensions.smallSpacing,
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: active
              ? AppColors.whiteText
              : AppColors.whiteText.withOpacity(0.7),
          fontWeight: active ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}
