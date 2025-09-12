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
        Text(
          estatistica.quantidadeFormatada,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.textoBranco,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppDimensions.espacamentoMuitoPequeno),
        Text(
          estatistica.rotulo.toUpperCase(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: AppColors.textoBranco.withOpacity(0.9),
            letterSpacing: 1.2,
            fontWeight: FontWeight.w500,
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
        vertical: AppDimensions.espacamentoExtraGrande,
        horizontal: AppDimensions.espacamentoMedio,
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
