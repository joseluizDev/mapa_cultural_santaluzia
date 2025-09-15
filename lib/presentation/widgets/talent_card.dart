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
        borderRadius: BorderRadius.circular(AppDimensions.veryLargeBorderRadius),
        border: Border.all(
          color: AppColors.cardBorder.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow.withOpacity(0.3),
            offset: const Offset(0, 6),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.veryLargeBorderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.cream.withOpacity(0.95),
                  AppColors.cream.withOpacity(0.85),
                ],
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(AppDimensions.veryLargeBorderRadius),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.mediumSpacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCabecalho(),
                      const SizedBox(height: AppDimensions.smallSpacing),
                      _buildDescricao(context),
                      const SizedBox(height: AppDimensions.smallSpacing),
                      _buildHabilidades(),
                      const Spacer(),
                      _buildRating(),
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
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.culturalBlue.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.culturalBlue.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: AppDimensions.cardAvatarSize / 2,
            backgroundImage: talento.imagemUrl.isNotEmpty
                ? NetworkImage(talento.imagemUrl)
                : null,
            backgroundColor: AppColors.lightGray,
            child: talento.imagemUrl.isEmpty
                ? Icon(
                    Icons.person,
                    size: AppDimensions.cardAvatarSize * 0.6,
                    color: AppColors.mediumGray,
                  )
                : null,
          ),
        ),
        const SizedBox(width: AppDimensions.mediumSpacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                talento.nome,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
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
                    size: 16,
                    color: AppColors.secondaryText,
                  ),
                  const SizedBox(width: AppDimensions.verySmallSpacing),
                  Expanded(
                    child: Text(
                      talento.localizacaoCompleta,
                      style: const TextStyle(
                        fontSize: 14,
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
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.primaryText,
            height: 1.5,
          ),
      maxLines: 2,
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
            color: AppColors.culturalBlue.withOpacity(0.15),
            borderRadius: BorderRadius.circular(AppDimensions.smallBorderRadius),
            border: Border.all(
              color: AppColors.culturalBlue.withOpacity(0.4),
              width: 0.8,
            ),
          ),
          child: Text(
            habilidade,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.culturalBlue,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          '${talento.rating}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '(${talento.totalRatings})',
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }
}