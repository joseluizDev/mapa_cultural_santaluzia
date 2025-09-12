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
        color: AppColors.fundoCardGlassmorphism,
        borderRadius: BorderRadius.circular(
          AppDimensions.bordaArredondadaMuitoGrande,
        ),
        border: Border.all(
          color: AppColors.bordaCard.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: AppShadows.sombraCard,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          AppDimensions.bordaArredondadaMuitoGrande,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.creme.withOpacity(0.9),
                  AppColors.creme.withOpacity(0.7),
                ],
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(
                  AppDimensions.bordaArredondadaMuitoGrande,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.espacamentoMedio),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCabecalho(),
                      const SizedBox(height: AppDimensions.espacamentoPequeno),
                      _buildDescricao(context),
                      const SizedBox(height: AppDimensions.espacamentoMedio),
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
          radius: AppDimensions.tamanhoAvatarCard / 2,
          backgroundImage: talento.imagemUrl.isNotEmpty
              ? NetworkImage(talento.imagemUrl)
              : null,
          backgroundColor: AppColors.cinzaClaro,
          child: talento.imagemUrl.isEmpty
              ? Icon(
                  Icons.person,
                  size: AppDimensions.tamanhoAvatarCard * 0.6,
                  color: AppColors.cinzaMedio,
                )
              : null,
        ),
        const SizedBox(width: AppDimensions.espacamentoMedio),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                talento.nome,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textoPrimario,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppDimensions.espacamentoMuitoPequeno),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 14,
                    color: AppColors.textoSecundario,
                  ),
                  const SizedBox(width: AppDimensions.espacamentoMuitoPequeno),
                  Expanded(
                    child: Text(
                      talento.localizacaoCompleta,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textoSecundario,
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
        color: AppColors.textoPrimario,
        height: 1.4,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildHabilidades() {
    return Wrap(
      spacing: AppDimensions.espacamentoPequeno,
      runSpacing: AppDimensions.espacamentoMuitoPequeno,
      children: talento.habilidades.take(3).map((habilidade) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.espacamentoPequeno,
            vertical: AppDimensions.espacamentoMuitoPequeno,
          ),
          decoration: BoxDecoration(
            color: AppColors.azulCultural.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              AppDimensions.bordaArredondadaPequena,
            ),
            border: Border.all(
              color: AppColors.azulCultural.withOpacity(0.3),
              width: 0.5,
            ),
          ),
          child: Text(
            habilidade,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.azulCultural,
            ),
          ),
        );
      }).toList(),
    );
  }
}
