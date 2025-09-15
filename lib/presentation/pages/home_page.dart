import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../domain/entities/advertisement.dart';
import '../../domain/entities/statistic.dart';
import '../../mock/talents_mock.dart';
import '../widgets/advertisement_carousel.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/statistics_section.dart';
import '../widgets/talent_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      currentPage: AppPage.home,
      body: CustomScrollView(
        slivers: [
          _buildHeroSection(context),
          _buildStatisticsSection(),
          _buildAdvertisementCarousel(),
          _buildTalentsSection(context),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Column(
          children: [
            const SizedBox(height: AppDimensions.extraLargeSpacing * 1.5),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.mediumSpacing,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppDimensions.maxContentWidth,
                ),
                child: Column(
                  children: [
                    Text(
                      'Descubra Famosos Incríveis na Sua Região',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: AppColors.whiteText,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                            shadows: [
                              Shadow(
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.largeSpacing),
                    Text(
                      'Conecte-se com famosos talentosos, artistas e\nempreendedores locais. Encontre o talento perfeito para seu\nprojeto ou negócio.',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.whiteText.withOpacity(0.95),
                            height: 1.6,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                offset: const Offset(1, 1),
                                blurRadius: 2,
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ],
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.extraLargeSpacing * 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsSection() {
    final estatisticas = [
      const Statistic(quantidade: 500, rotulo: 'Famosos'),
      const Statistic(quantidade: 50, rotulo: 'Cidades'),
      const Statistic(quantidade: 1000, rotulo: 'Conexões'),
    ];

    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: StatisticsSection(estatisticas: estatisticas),
      ),
    );
  }

  Widget _buildAdvertisementCarousel() {
    final propagandas = _getMockAdvertisements();

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.mediumSpacing,
          vertical: AppDimensions.largeSpacing,
        ),
        child: Builder(
          builder: (context) {
            return ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppDimensions.maxContentWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Destaques',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: AppDimensions.mediumSpacing),
                  Text(
                    'Confira as últimas novidades e oportunidades',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.secondaryText,
                        ),
                  ),
                  const SizedBox(height: AppDimensions.largeSpacing),
                  AdvertisementCarousel(propagandas: propagandas),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildTalentsSection(BuildContext context) {
    final talentos = getMockTalents();

    return SliverPadding(
      padding: const EdgeInsets.all(AppDimensions.extraLargeSpacing),
      sliver: SliverToBoxAdapter(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppDimensions.maxContentWidth,
          ),
          child: Column(
            children: [
              Text(
                'Famosos em Destaque',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.smallSpacing),
              Text(
                'Conheça alguns dos talentos mais populares',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.secondaryText,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.extraLargeSpacing),
              LayoutBuilder(
                builder: (context, constraints) {
                  final largura = constraints.maxWidth;
                  int colunas = 1;

                  if (largura > AppDimensions.desktopBreakpoint) {
                    colunas = 3;
                  } else if (largura > AppDimensions.tabletBreakpoint) {
                    colunas = 2;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: colunas,
                      crossAxisSpacing: AppDimensions.largeSpacing,
                      mainAxisSpacing: AppDimensions.largeSpacing,
                      childAspectRatio: 1.6,
                    ),
                    itemCount: talentos.length,
                    itemBuilder: (context, index) {
                      return TalentCard(
                        talento: talentos[index],
                        onTap: () {
                          GoRouter.of(context).goNamed(
                            'talent_detail',
                            pathParameters: {'name': talentos[index].nome},
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Advertisement> _getMockAdvertisements() {
    return [
      Advertisement(
        nome: 'Festival de Inverno 2025',
        imagemUrl:
            'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=800&h=300&fit=crop',
        dataInicio: DateTime(2025, 6, 15),
        dataFim: DateTime(2025, 7, 15),
        ativa: true,
      ),
      Advertisement(
        nome: 'Exposição de Arte Local',
        imagemUrl:
            'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=300&fit=crop',
        dataInicio: DateTime(2025, 5, 1),
        dataFim: DateTime(2025, 5, 31),
        ativa: true,
      ),
      Advertisement(
        nome: 'Concurso de Talentos',
        imagemUrl:
            'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=800&h=300&fit=crop',
        dataInicio: DateTime(2025, 4, 10),
        dataFim: DateTime(2025, 4, 30),
        ativa: true,
      ),
    ];
  }
}