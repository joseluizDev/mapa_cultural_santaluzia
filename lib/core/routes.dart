import 'package:go_router/go_router.dart';
import 'package:mapa_cultural_santaluzia/presentation/pages/about_page.dart';
import 'package:mapa_cultural_santaluzia/presentation/pages/advertisement_page.dart';
import 'package:mapa_cultural_santaluzia/presentation/pages/talent_detail_page.dart';

import '../presentation/pages/home_page.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/register_page.dart';
import '../presentation/pages/verification_code_page.dart';

/// Classe responsável pela configuração das rotas do aplicativo
class AppRoutes {
  /// Rota inicial do aplicativo (home)
  static const String initial = '/';

  /// Rota da página de login
  static const String login = '/login';

  /// Rota da página de registro
  static const String register = '/register';

  /// Rota da página de verificação de código
  static const String verifyCode = '/verify-code';

  /// Rota da página sobre
  static const String about = '/about';

  /// Rota da página inicial (home)
  static const String home = '/home';

  /// Rota da página de propagandas
  static const String ads = '/ads';

  /// Configuração do GoRouter com todas as rotas definidas
  static final GoRouter router = GoRouter(
    initialLocation: initial,
    routes: [
      // Rota inicial redireciona para home
      GoRoute(path: initial, redirect: (context, state) => home),

      // Rota da página de login
      GoRoute(path: login, builder: (context, state) => const LoginPage()),

      // Rota da página de registro
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterPage(),
      ),

      // Rota da página de verificação de código
      GoRoute(
        path: verifyCode,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final contact = extra?['contact'] ?? '';
          final contactType = extra?['contactType'] ?? 'email';
          return VerificationCodePage(
            contact: contact,
            contactType: contactType,
          );
        },
      ),

      // Rota da página sobre
      GoRoute(path: about, builder: (context, state) => const AboutPage()),

      // Rota da página inicial (home)
      GoRoute(path: home, builder: (context, state) => const HomePage()),

      // Rota da página de propagandas
      GoRoute(
        path: ads,
        builder: (context, state) => const AdvertisementPage(),
      ),

      // Rota de detalhes de talento (usa nome como identificador simplificado)
      GoRoute(
        name: 'talent_detail',
        path: '/talent/:name',
        builder: (context, state) {
          final nome = state.pathParameters['name'] ?? '';
          return TalentDetailPage(nomeTalento: nome);
        },
      ),

      // Rota da página de anúncios
      GoRoute(
        path: '/ads',
        builder: (context, state) => const AdvertisementPage(),
      ),
    ],
  );
}
