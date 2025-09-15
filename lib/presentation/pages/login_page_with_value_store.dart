import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_cultural_santaluzia/core/state/value_store.dart';
import 'package:mapa_cultural_santaluzia/domain/usecases/login_usecase.dart';
import 'package:mapa_cultural_santaluzia/domain/usecases/register_usecase.dart';
import 'package:mapa_cultural_santaluzia/presentation/stores/auth_value_store.dart';

import 'login_page.dart';

class LoginPageWithValueStore extends StatefulWidget {
  const LoginPageWithValueStore({super.key});

  @override
  State<LoginPageWithValueStore> createState() =>
      _LoginPageWithValueStoreState();
}

class _LoginPageWithValueStoreState extends State<LoginPageWithValueStore> {
  late AuthValueStore _authStore;

  @override
  void initState() {
    super.initState();
    // Initialize the store with necessary use cases
    _authStore = AuthValueStore(
      loginUseCase: LoginUseCase(),
      registerUseCase: RegisterUseCase(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConsumer<AuthState>(
      store: _authStore,
      // When in initial state, show the login page
      initialBuilder: (context) => _buildLoginPageContent(),
      // When loading, show a loading indicator
      loadingBuilder: (context) =>
          Scaffold(body: Center(child: CircularProgressIndicator())),
      // When there's an error, show the login page with the error message
      errorBuilder: (context, message) {
        // Show the error snackbar after the build is complete
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        });
        return _buildLoginPageContent();
      },
      // When successful (sent verification code or logged in)
      builder: (context, authState) {
        // If user is logged in, navigate to home
        if (authState.user != null) {
          // Navigate to home after the build is complete
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/home');
          });
          // Show loading while navigation happens
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If verification code is sent, navigate to verification page
        if (authState.isVerificationSent) {
          // Navigate to verification after the build is complete
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(
              '/verify-code',
              extra: {
                'contact': authState.verificationContact,
                'contactType': authState.verificationContactType,
              },
            );
          });
          // Show loading while navigation happens
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Otherwise, show the login page
        return _buildLoginPageContent();
      },
    );
  }

  Widget _buildLoginPageContent() {
    // Use the original LoginPage but provide a callback for authentication
    return LoginPage(
      onLogin: (email, password) {
        _authStore.sendLoginVerificationCode(email, 'email');
      },
    );
  }
}
