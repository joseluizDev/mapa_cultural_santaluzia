import 'package:go_router/go_router.dart';

import '../presentation/pages/home_page.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/register_page.dart';

/// Classe responsável pela configuração das rotas do aplicativo
class AppRoutes {
  /// Rota inicial do aplicativo (home)
  static const String initial = '/';

  /// Rota da página de login
  static const String login = '/login';

  /// Rota da página de registro
  static const String register = '/register';

  /// Rota da página inicial (home)
  static const String home = '/home';

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

      // Rota da página inicial (home)
      GoRoute(path: home, builder: (context, state) => const HomePage()),
    ],
  );
}
