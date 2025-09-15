import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../domain/entities/statistic.dart';

class StatisticWidget extends StatelessWidget {
  final Statistic estatistica;

  const StatisticWidget({super.key, required this.estatistica});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white.withOpacity(0.2),
            border: Border.all(
              color: AppColors.white.withOpacity(0.4),
              width: 2,
            ),
          ),
          child: Text(
            estatistica.quantidadeFormatada,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.whiteText,
                  fontWeight: FontWeight.w800,
                  shadows: [
                    Shadow(
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
          ),
        ),
        const SizedBox(height: AppDimensions.smallSpacing),
        Text(
          estatistica.rotulo.toUpperCase(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.whiteText.withOpacity(0.9),
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    offset: const Offset(1, 1),
                    blurRadius: 1,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
        ),
      ],
    );
  }
}

class StatisticsSection extends StatelessWidget {
  final List<Statistic> estatisticas;

  const StatisticsSection({super.key, required this.estatisticas});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.extraLargeSpacing * 1.5,
        horizontal: AppDimensions.mediumSpacing,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: estatisticas
            .map((estatistica) => StatisticWidget(estatistica: estatistica))
            .toList(),
      ),
    );
  }
}