import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapa_cultural_santaluzia/presentation/widgets/custom_scaffold.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  late AnimationController _heroController;
  late AnimationController _missionController;
  late AnimationController _valuesController;
  late AnimationController _impactController;
  late AnimationController _stepsController;
  late AnimationController _ctaController;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _heroController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _missionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _valuesController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _impactController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _stepsController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _ctaController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Trigger animations on scroll (simplified)
    Future.delayed(const Duration(milliseconds: 500), () {
      _missionController.forward();
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      _valuesController.forward();
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      _impactController.forward();
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      _stepsController.forward();
    });

    Future.delayed(const Duration(milliseconds: 2500), () {
      _ctaController.forward();
    });
  }

  @override
  void dispose() {
    _heroController.dispose();
    _missionController.dispose();
    _valuesController.dispose();
    _impactController.dispose();
    _stepsController.dispose();
    _ctaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      currentPage: AppPage.about,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            _buildMissionCard(),
            _buildValuesSection(),
            _buildImpactSection(),
            _buildHowItWorksSection(),
            _buildCallToActionSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return AnimatedBuilder(
      animation: _heroController,
      builder: (context, child) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0xFFc63122), // Vermelho Brasil
                Color(0xFF115a91), // Azul Profundo
                Color(0xFF447832), // Verde Brasileiro
              ],
            ),
          ),
          child: Stack(
            children: [
              // Padrão de fundo
              Opacity(
                opacity: 0.1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/images/pattern.png'),
                      repeat: ImageRepeat.repeat,
                      scale: 0.5,
                    ),
                  ),
                ),
              ),
              // Conteúdo principal
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.translate(
                        offset: Offset(0, _heroController.value * -20),
                        child: Opacity(
                          opacity: _heroController.value,
                          child: Text(
                            'Famosos Locais',
                            style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.width < 640
                                  ? 32
                                  : MediaQuery.of(context).size.width < 1024
                                  ? 48
                                  : 64,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFf3e2c6),
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(0, 4),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Transform.translate(
                        offset: Offset(0, _heroController.value * 20),
                        child: Opacity(
                          opacity: _heroController.value,
                          child: Text(
                            'Conectando artistas e fortalecendo a cultura local de Santa Luzia',
                            style: GoogleFonts.inter(
                              fontSize: MediaQuery.of(context).size.width < 640
                                  ? 16
                                  : 20,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMissionCard() {
    return AnimatedBuilder(
      animation: _missionController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _missionController.value) * 50),
          child: Opacity(
            opacity: _missionController.value,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 64,
                    offset: const Offset(0, 32),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text('🎭', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 24),
                  Text(
                    'Nossa Missão',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1f2937),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Criar uma plataforma que valorize e conecte os artistas locais de Santa Luzia, promovendo a diversidade cultural e fortalecendo a identidade da nossa comunidade através da visibilidade e reconhecimento do talento local.',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xFF4b5563),
                      height: 1.7,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildValuesSection() {
    return AnimatedBuilder(
      animation: _valuesController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _valuesController.value) * 30),
          child: Opacity(
            opacity: _valuesController.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
              child: Column(
                children: [
                  Text(
                    'Nossos Valores',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1f2937),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Princípios que guiam nossa comunidade',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: const Color(0xFF6b7280),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 640;
                      final isTablet = constraints.maxWidth < 1024;

                      return GridView.count(
                        crossAxisCount: isMobile
                            ? 1
                            : isTablet
                            ? 2
                            : 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 24,
                        crossAxisSpacing: 24,
                        children: [
                          _buildValueCard(
                            icon: '👁️',
                            title: 'Dar Visibilidade',
                            description:
                                'Cada artista merece ser visto e reconhecido pela comunidade',
                          ),
                          _buildValueCard(
                            icon: '🤝',
                            title: 'Fortalecer a Rede',
                            description:
                                'Conectar artistas, grupos e iniciativas culturais locais',
                          ),
                          _buildValueCard(
                            icon: '🌈',
                            title: 'Celebrar a Diversidade',
                            description:
                                'Valorizar todas as formas de expressão cultural do município',
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildValueCard({
    required String icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFf3e2c6).withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1f2937),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF6b7280),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildImpactSection() {
    return AnimatedBuilder(
      animation: _impactController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _impactController.value) * 30),
          child: Opacity(
            opacity: _impactController.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: const [Color(0xFFf3e2c6), Color(0xFFe8d5b7)],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Nosso Impacto',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1f2937),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Números que contam nossa história',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: const Color(0xFF6b7280),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 640;

                      return GridView.count(
                        crossAxisCount: isMobile ? 2 : 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 24,
                        crossAxisSpacing: 24,
                        children: [
                          _buildStatCard('500+', 'Artistas Cadastrados'),
                          _buildStatCard('50+', 'Grupos Culturais'),
                          _buildStatCard('1000+', 'Visitantes Mensais'),
                          _buildStatCard('25+', 'Tipos de Arte'),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFc63122),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF6b7280),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksSection() {
    return AnimatedBuilder(
      animation: _stepsController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _stepsController.value) * 30),
          child: Opacity(
            opacity: _stepsController.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
              child: Column(
                children: [
                  Text(
                    'Como Funciona',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1f2937),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Três passos simples para fazer parte da comunidade',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: const Color(0xFF6b7280),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  _buildStep(
                    number: '1',
                    title: 'Crie sua Conta',
                    description:
                        'Faça seu cadastro gratuito e tenha acesso à plataforma',
                    icon: '✍️',
                  ),
                  const SizedBox(height: 32),
                  _buildStep(
                    number: '2',
                    title: 'Complete seu Perfil',
                    description:
                        'Adicione suas informações, fotos e descrição do seu trabalho',
                    icon: '👤',
                  ),
                  const SizedBox(height: 32),
                  _buildStep(
                    number: '3',
                    title: 'Conecte-se',
                    description:
                        'Explore outros artistas e fortaleça a rede cultural local',
                    icon: '🔗',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStep({
    required String number,
    required String title,
    required String description,
    required String icon,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 640;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: isMobile
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFc63122), Color(0xFF115a91)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              number,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(icon, style: const TextStyle(fontSize: 32)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1f2937),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF6b7280),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFc63122), Color(0xFF115a91)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          number,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Text(icon, style: const TextStyle(fontSize: 32)),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1f2937),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0xFF6b7280),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildCallToActionSection() {
    return AnimatedBuilder(
      animation: _ctaController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _ctaController.value) * 30),
          child: Opacity(
            opacity: _ctaController.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: const [Color(0xFF115a91), Color(0xFFc63122)],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Junte-se à Nossa Comunidade',
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width < 640
                          ? 28
                          : 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 2),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Seja parte da transformação cultural de Santa Luzia',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/register');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF447832),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                      shadowColor: Colors.black.withOpacity(0.3),
                    ),
                    child: Text(
                      'Começar Agora',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
