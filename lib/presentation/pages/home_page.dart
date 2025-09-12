import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../domain/entities/advertisement.dart';
import '../../domain/entities/statistic.dart';
import '../../domain/entities/talent.dart';
import '../widgets/advertisement_carousel.dart';
import '../widgets/buttons.dart';
import '../widgets/gradient_app_bar.dart';
import '../widgets/statistics_section.dart';
import '../widgets/talent_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fundoClaro,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          _buildHeroSection(context),
          _buildStatisticsSection(),
          _buildAdvertisementCarousel(),
          _buildTalentsSection(context),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 80,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.gradientePrimario,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.espacamentoMedio,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Famosos Locais',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textoBranco,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      NavigationButton(texto: 'Início', ativo: true),
                      NavigationButton(texto: 'Sobre'),
                      NavigationButton(texto: 'Propagandas'),
                      NavigationButton(texto: 'Entrar'),
                      const SizedBox(width: AppDimensions.espacamentoMedio),
                      PrimaryButton(texto: 'Criar conta', onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(gradient: AppColors.gradientePrimario),
        child: Column(
          children: [
            const SizedBox(height: AppDimensions.espacamentoExtraGrande),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.espacamentoMedio,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppDimensions.larguraMaximaConteudo,
                ),
                child: Column(
                  children: [
                    Text(
                      'Descubra Famosos Incríveis na Sua Região',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            color: AppColors.textoBranco,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.espacamentoGrande),
                    Text(
                      'Conecte-se com famosos talentosos, artistas e\nempreendedores locais. Encontre o talento perfeito para seu\nprojeto ou negócio.',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textoBranco.withOpacity(0.9),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: AppDimensions.espacamentoExtraGrande,
                    ),
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
        decoration: const BoxDecoration(gradient: AppColors.gradientePrimario),
        child: StatisticsSection(estatisticas: estatisticas),
      ),
    );
  }

  Widget _buildAdvertisementCarousel() {
    final propagandas = _getMockAdvertisements();

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.espacamentoMedio,
          vertical: AppDimensions.espacamentoGrande,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppDimensions.larguraMaximaConteudo,
          ),
          child: AdvertisementCarousel(propagandas: propagandas),
        ),
      ),
    );
  }

  Widget _buildTalentsSection(BuildContext context) {
    final talentos = _getMockTalents();

    return SliverPadding(
      padding: const EdgeInsets.all(AppDimensions.espacamentoExtraGrande),
      sliver: SliverToBoxAdapter(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppDimensions.larguraMaximaConteudo,
          ),
          child: Column(
            children: [
              Text(
                'Famosos em Destaque',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textoPrimario,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.espacamentoExtraGrande),
              LayoutBuilder(
                builder: (context, constraints) {
                  final largura = constraints.maxWidth;
                  int colunas = 1;

                  if (largura > AppDimensions.breakpointDesktop) {
                    colunas = 3;
                  } else if (largura > AppDimensions.breakpointTablet) {
                    colunas = 2;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: colunas,
                      crossAxisSpacing: AppDimensions.espacamentoGrande,
                      mainAxisSpacing: AppDimensions.espacamentoGrande,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: talentos.length,
                    itemBuilder: (context, index) {
                      return TalentCard(
                        talento: talentos[index],
                        onTap: () {
                          // Implementar navegação para detalhes do talento
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

  List<Talent> _getMockTalents() {
    return [
      const Talent(
        nome: 'Lucas Mendes',
        cidade: 'Curitiba',
        estado: 'PR',
        descricao: 'Consultor financeiro com experiência em investimentos e...',
        imagemUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
        habilidades: [
          'Consultoria Financeira',
          'Investimentos',
          'Análise de Risco',
          'Planejamento',
        ],
      ),
      const Talent(
        nome: 'Patricia Costa',
        cidade: 'Salvador',
        estado: 'BA',
        descricao: 'Tradutora e intérprete com fluência em 5 idiomas...',
        imagemUrl:
            'https://images.unsplash.com/photo-1494790108755-2616b612b6c8?w=150&h=150&fit=crop&crop=face',
        habilidades: ['Tradução', 'Inglês', 'Espanhol', 'Francês', 'Alemão'],
      ),
      const Talent(
        nome: 'Ana Silva',
        cidade: 'São Paulo',
        estado: 'SP',
        descricao:
            'Designer gráfica com 5 anos de experiência em branding e...',
        imagemUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
        habilidades: [
          'Design Gráfico',
          'Branding',
          'Adobe Creative Suite',
          'UI/UX',
        ],
      ),
      const Talent(
        nome: 'Roberto Alves',
        cidade: 'Porto Alegre',
        estado: 'RS',
        descricao: 'Fotógrafo profissional especializado em eventos e...',
        imagemUrl:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        habilidades: ['Fotografia', 'Edição de Imagem', 'Google Ads'],
      ),
      const Talent(
        nome: 'Fernanda Lima',
        cidade: 'Belo Horizonte',
        estado: 'MG',
        descricao: 'Especialista em Marketing Digital e SEO com foco em...',
        imagemUrl:
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
        habilidades: ['Marketing Digital', 'SEO'],
      ),
      const Talent(
        nome: 'Carlos Santos',
        cidade: 'Rio de Janeiro',
        estado: 'RJ',
        descricao: 'Desenvolvedor Full Stack especializado em React e...',
        imagemUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
        habilidades: ['React', 'Node.js', 'TypeScript', 'MongoDB'],
      ),
    ];
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
