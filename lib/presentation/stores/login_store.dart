import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'base_store.dart';

class LoginStore extends BaseStore with LoadingState, ErrorState {
  LoginStore() {
    // Register loading and error notifiers for automatic disposal
    register(isLoading);
    register(errorMessage);
  }

  /// Login user with phone and password
  Future<void> loginUser({
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      // Simulate login verification
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;

      // For demonstration, accept any password
      if (phone.isNotEmpty && password.isNotEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login realizado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to home
          context.go('/home');
        }
      } else {
        errorMessage.value = 'Credenciais inválidas. Tente novamente.';
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Erro inesperado. Tente novamente.';
    }
  }
}