import 'package:go_router/go_router.dart';
import 'package:mapa_cultural_santaluzia/presentation/pages/about_page.dart';
import 'package:mapa_cultural_santaluzia/presentation/pages/advertisement_page.dart';
import 'package:mapa_cultural_santaluzia/presentation/pages/complete_profile_page_with_value_store.dart';
import 'package:mapa_cultural_santaluzia/presentation/pages/login_page_with_value_store.dart';
import 'package:mapa_cultural_santaluzia/presentation/pages/register_page_with_value_store.dart';
import 'package:mapa_cultural_santaluzia/presentation/pages/talent_detail_page.dart';
import 'package:mapa_cultural_santaluzia/presentation/pages/verification_code_page_with_value_store.dart';

import '../presentation/pages/home_page.dart';

/// Classe responsável pela configuração das rotas do aplicativo com ValueNotifier
class AppRoutesWithValueStore {
  /// Rota inicial do aplicativo (home)
  static const String initial = '/';

  /// Rota da página de login
  static const String login = '/login';

  /// Rota da página de registro
  static const String register = '/register';

  /// Rota da página de verificação de código
  static const String verifyCode = '/verify-code';

  /// Rota da página de completar perfil
  static const String completeProfile = '/complete-profile';

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
      GoRoute(path: initial, redirect: (context, state) => login),

      // Rota da página de login com ValueNotifier
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPageWithValueStore(),
      ),

      // Rota da página de registro com ValueNotifier
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterPageWithValueStore(),
      ),

      // Rota da página de verificação de código com ValueNotifier
      GoRoute(
        path: verifyCode,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final contact = extra?['contact'] ?? '';
          final contactType = extra?['contactType'] ?? 'email';
          return VerificationCodePageWithValueStore(
            contact: contact,
            contactType: contactType,
          );
        },
      ),

      // Rota da página de completar perfil com ValueNotifier
      GoRoute(
        path: completeProfile,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final contact = extra?['contact'] ?? '';
          final contactType = extra?['contactType'] ?? 'email';
          return CompleteProfilePageWithValueStore(
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
    ],
  );
}
