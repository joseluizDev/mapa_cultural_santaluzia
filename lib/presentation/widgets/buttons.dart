import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';

class PrimaryButton extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final bool carregando;
  final IconData? icone;

  const PrimaryButton({
    super.key,
    required this.texto,
    this.onPressed,
    this.carregando = false,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: carregando ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.azulCultural,
        foregroundColor: AppColors.textoBranco,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.espacamentoGrande,
          vertical: AppDimensions.espacamentoMedio,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.bordaArredondadaMedia,
          ),
        ),
        elevation: 2,
      ),
      child: carregando
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.textoBranco,
                ),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icone != null) ...[
                  Icon(icone, size: 18),
                  const SizedBox(width: AppDimensions.espacamentoPequeno),
                ],
                Text(
                  texto,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final IconData? icone;

  const SecondaryButton({
    super.key,
    required this.texto,
    this.onPressed,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.azulCultural,
        side: const BorderSide(color: AppColors.azulCultural),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.espacamentoGrande,
          vertical: AppDimensions.espacamentoMedio,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.bordaArredondadaMedia,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icone != null) ...[
            Icon(icone, size: 18),
            const SizedBox(width: AppDimensions.espacamentoPequeno),
          ],
          Text(
            texto,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
