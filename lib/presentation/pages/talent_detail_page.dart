import 'package:flutter/material.dart';
import 'package:mapa_cultural_santaluzia/presentation/widgets/custom_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../domain/entities/talent.dart';
import '../../mock/talents_mock.dart';

/// Página de detalhes de um talento.
/// Exibe informações completas sobre o talento selecionado.
class TalentDetailPage extends StatelessWidget {
  final String nomeTalento;

  const TalentDetailPage({super.key, required this.nomeTalento});

  @override
  Widget build(BuildContext context) {
    // Encontra o talento pelos dados mocados
    final talento = _encontrarTalento();

    if (talento == null) {
      return _buildErroPage(context);
    }

    return CustomScaffold(
      currentPage: AppPage
          .home, // Não tem página específica para detalhes, então usa home
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(AppDimensions.mediumSpacing),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 800, // Largura máxima para os cards
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildHeader(talento),
                      const SizedBox(height: AppDimensions.largeSpacing),
                      _buildHabilidadesSection(talento),
                      const SizedBox(height: AppDimensions.largeSpacing),
                      _buildDescricaoSection(talento),
                      const SizedBox(height: AppDimensions.largeSpacing),
                      _buildLocalizacaoSection(talento),
                      const SizedBox(height: AppDimensions.largeSpacing),
                      _buildContatoSection(talento),
                      const SizedBox(height: AppDimensions.largeSpacing),
                      _buildAvaliacaoSection(context, talento),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Talent? _encontrarTalento() {
    final talentos = getMockTalents();
    try {
      return talentos.firstWhere((talento) => talento.nome == nomeTalento);
    } catch (e) {
      return null;
    }
  }

  Future<void> _abrirInstagram(String username) async {
    final url = 'https://instagram.com/$username';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      // Fallback: tentar abrir no navegador
      await launchUrl(Uri.parse(url));
    }
  }

  Future<void> _abrirWhatsApp(String telefone) async {
    // Remove caracteres não numéricos e formata para WhatsApp
    final numeroLimpo = telefone.replaceAll(RegExp(r'[^\d]'), '');
    final url = 'https://wa.me/$numeroLimpo';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      // Fallback: tentar abrir no navegador
      await launchUrl(Uri.parse(url));
    }
  }

  Widget _buildErroPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.primaryText,
              ),
              const SizedBox(height: AppDimensions.mediumSpacing),
              Text(
                'Talento não encontrado',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppDimensions.smallSpacing),
              Text(
                'O talento "$nomeTalento" não foi encontrado.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.largeSpacing),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.culturalRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.largeSpacing,
                    vertical: AppDimensions.mediumSpacing,
                  ),
                ),
                child: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 60,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.cream,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppColors.cream,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.mediumSpacing,
                vertical: AppDimensions.smallSpacing,
              ),
              child: _BotaoVoltar(onPressed: () => Navigator.of(context).pop()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Talent talento) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.largeSpacing),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppDimensions.largeBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppDimensions.largeBorderRadius,
              ),
              image: DecorationImage(
                image: NetworkImage(talento.imagemUrl),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: AppColors.white.withOpacity(0.8),
                width: 3,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.mediumSpacing),
          // Informações básicas
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  talento.nome,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: AppDimensions.smallSpacing),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${talento.cidade}, ${talento.estado}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescricaoSection(Talent talento) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.largeSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.largeBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sobre',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: AppDimensions.mediumSpacing),
          Text(
            talento.descricao,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.secondaryText,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabilidadesSection(Talent talento) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.largeSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.largeBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Habilidades',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: AppDimensions.mediumSpacing),
          Wrap(
            spacing: AppDimensions.smallSpacing,
            runSpacing: AppDimensions.smallSpacing,
            children: talento.habilidades.map((habilidade) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.mediumSpacing,
                  vertical: AppDimensions.smallSpacing,
                ),
                decoration: BoxDecoration(
                  color: AppColors.culturalBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    AppDimensions.mediumBorderRadius,
                  ),
                  border: Border.all(
                    color: AppColors.culturalBlue.withOpacity(0.2),
                  ),
                ),
                child: Text(
                  habilidade,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.culturalBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLocalizacaoSection(Talent talento) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.largeSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.largeBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Localização',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: AppDimensions.mediumSpacing),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.smallSpacing),
                decoration: BoxDecoration(
                  color: AppColors.brazilianGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    AppDimensions.mediumBorderRadius,
                  ),
                ),
                child: const Icon(
                  Icons.location_city,
                  color: AppColors.brazilianGreen,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppDimensions.mediumSpacing),
              Expanded(
                child: Text(
                  '${talento.cidade}, ${talento.estado}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvaliacaoSection(BuildContext context, Talent talento) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.largeSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.largeBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Avaliações',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: AppDimensions.mediumSpacing),
          // Rating médio e total de avaliações
          Row(
            children: [
              Text(
                talento.rating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(width: AppDimensions.smallSpacing),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < talento.rating.floor()
                            ? Icons.star
                            : index < talento.rating
                            ? Icons.star_half
                            : Icons.star_border,
                        color: AppColors.culturalRed,
                        size: 20,
                      );
                    }),
                  ),
                  Text(
                    '${talento.totalRatings} avaliações',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.largeSpacing),
          // Botão para avaliar
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Implementar diálogo de avaliação
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Funcionalidade em desenvolvimento'),
                  ),
                );
              },
              icon: const Icon(Icons.star_border, color: Colors.white),
              label: const Text('Avaliar este talento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.culturalRed,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.mediumBorderRadius,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.largeSpacing),
          // Lista de avaliações
          if (talento.ratings.isNotEmpty) ...[
            const Text(
              'Comentários recentes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: AppDimensions.mediumSpacing),
            ...talento.ratings.map(
              (rating) => Container(
                margin: const EdgeInsets.only(
                  bottom: AppDimensions.mediumSpacing,
                ),
                padding: const EdgeInsets.all(AppDimensions.mediumSpacing),
                decoration: BoxDecoration(
                  color: AppColors.cream.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(
                    AppDimensions.mediumBorderRadius,
                  ),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          rating.userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryText,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < rating.rating.floor()
                                  ? Icons.star
                                  : index < rating.rating
                                  ? Icons.star_half
                                  : Icons.star_border,
                              color: AppColors.culturalRed,
                              size: 16,
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.smallSpacing),
                    Text(
                      rating.comment ?? 'Sem comentário',
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.smallSpacing),
                    Text(
                      '${rating.date.day}/${rating.date.month}/${rating.date.year}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContatoSection(Talent talento) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.largeSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.largeBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contato',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: AppDimensions.mediumSpacing),
          const Text(
            'Entre em contato para conhecer melhor os serviços oferecidos.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.secondaryText,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppDimensions.largeSpacing),
          // Botão de email
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Implementar ação de contato por email
              },
              icon: const Icon(Icons.email),
              label: const Text('Enviar Mensagem'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.culturalRed,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.mediumSpacing,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.mediumBorderRadius,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.mediumSpacing),
          // Redes sociais
          Row(
            children: [
              // Instagram
              if (talento.instagram != null) ...[
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _abrirInstagram(talento.instagram!),
                    icon: const Icon(Icons.camera_alt),
                    label: Text(talento.instagram!),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFFE4405F,
                      ), // Cor do Instagram
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.mediumSpacing,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.mediumBorderRadius,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.smallSpacing),
              ],
              // WhatsApp
              if (talento.whatsapp != null) ...[
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _abrirWhatsApp(talento.whatsapp!),
                    icon: const Icon(Icons.message),
                    label: const Text('WhatsApp'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF25D366,
                      ), // Cor do WhatsApp
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.mediumSpacing,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.mediumBorderRadius,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              // Compartilhar (sempre visível)
              if (talento.instagram == null && talento.whatsapp == null) ...[
                Container(
                  padding: const EdgeInsets.all(AppDimensions.smallSpacing),
                  decoration: BoxDecoration(
                    color: AppColors.culturalBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.mediumBorderRadius,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // TODO: Implementar compartilhamento
                    },
                    icon: const Icon(Icons.share),
                    color: AppColors.culturalBlue,
                  ),
                ),
              ] else if (talento.instagram != null ||
                  talento.whatsapp != null) ...[
                const SizedBox(width: AppDimensions.smallSpacing),
                Container(
                  padding: const EdgeInsets.all(AppDimensions.smallSpacing),
                  decoration: BoxDecoration(
                    color: AppColors.culturalBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.mediumBorderRadius,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // TODO: Implementar compartilhamento
                    },
                    icon: const Icon(Icons.share),
                    color: AppColors.culturalBlue,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _BotaoVoltar extends StatelessWidget {
  final VoidCallback onPressed;
  const _BotaoVoltar({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.mediumSpacing,
          vertical: AppDimensions.smallSpacing,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.arrow_back, size: 18, color: AppColors.primaryText),
            SizedBox(width: AppDimensions.smallSpacing),
            Text(
              'Voltar para a lista',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
