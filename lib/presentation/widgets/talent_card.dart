import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../domain/entities/talent.dart';

class TalentCard extends StatelessWidget {
  final Talent talento;
  final VoidCallback? onTap;

  const TalentCard({super.key, required this.talento, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardGlassmorphismBackground,
        borderRadius: BorderRadius.circular(
          AppDimensions.veryLargeBorderRadius,
        ),
        border: Border.all(
          color: AppColors.cardBorder.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: AppShadows.cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          AppDimensions.veryLargeBorderRadius,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.cream.withOpacity(0.9),
                  AppColors.cream.withOpacity(0.7),
                ],
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(
                  AppDimensions.veryLargeBorderRadius,
                ),
                child: Padding(
                  // Redução de padding para diminuir altura total do card
                  padding: const EdgeInsets.all(AppDimensions.smallSpacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCabecalho(),
                      const SizedBox(height: AppDimensions.verySmallSpacing),
                      _buildDescricao(context),
                      const SizedBox(height: AppDimensions.smallSpacing),
                      _buildHabilidades(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCabecalho() {
    return Row(
      children: [
        CircleAvatar(
          // Avatar ligeiramente menor para reduzir altura
          radius: (AppDimensions.cardAvatarSize * 0.8) / 2,
          backgroundImage: talento.imagemUrl.isNotEmpty
              ? NetworkImage(talento.imagemUrl)
              : null,
          backgroundColor: AppColors.lightGray,
          child: talento.imagemUrl.isEmpty
              ? Icon(
                  Icons.person,
                  size: AppDimensions.cardAvatarSize * 0.48,
                  color: AppColors.mediumGray,
                )
              : null,
        ),
        const SizedBox(width: AppDimensions.mediumSpacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                talento.nome,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppDimensions.verySmallSpacing),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 14,
                    color: AppColors.secondaryText,
                  ),
                  const SizedBox(width: AppDimensions.verySmallSpacing),
                  Expanded(
                    child: Text(
                      talento.localizacaoCompleta,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.secondaryText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescricao(BuildContext context) {
    return Text(
      talento.descricao,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: AppColors.primaryText,
        height: 1.4,
      ),
      // Menos linhas para reduzir altura
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildHabilidades() {
    return Wrap(
      spacing: AppDimensions.smallSpacing,
      runSpacing: AppDimensions.verySmallSpacing,
      children: talento.habilidades.take(3).map((habilidade) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.smallSpacing,
            vertical: AppDimensions.verySmallSpacing,
          ),
          decoration: BoxDecoration(
            color: AppColors.culturalBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              AppDimensions.smallBorderRadius,
            ),
            border: Border.all(
              color: AppColors.culturalBlue.withOpacity(0.3),
              width: 0.5,
            ),
          ),
          child: Text(
            habilidade,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.culturalBlue,
            ),
          ),
        );
      }).toList(),
    );
  }
}
