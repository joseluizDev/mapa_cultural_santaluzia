import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../core/services/verification_service.dart';
import 'base_store.dart';

class RegisterStore extends BaseStore with LoadingState, ErrorState {
  // Form state notifiers
  late final ValueNotifier<bool> acceptTerms = register(ValueNotifier(false));
  late final ValueNotifier<bool> isEmailSelected = register(ValueNotifier(true));

  RegisterStore() {
    // Register loading and error notifiers for automatic disposal
    register(isLoading);
    register(errorMessage);
  }

  /// Toggle terms acceptance
  void toggleTermsAcceptance() {
    acceptTerms.value = !acceptTerms.value;
  }

  /// Set contact method to email
  void setEmailSelected() {
    isEmailSelected.value = true;
  }

  /// Set contact method to phone
  void setPhoneSelected() {
    isEmailSelected.value = false;
  }

  /// Register user with verification
  Future<void> registerUser({
    required String contact,
    required String password,
    required BuildContext context,
  }) async {
    if (!acceptTerms.value) {
      errorMessage.value = 'Você deve aceitar os termos de uso';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final contactType = isEmailSelected.value ? 'email' : 'phone';
      bool success = false;

      if (isEmailSelected.value) {
        success = await VerificationService.sendVerificationCodeByEmail(contact);
      } else {
        success = await VerificationService.sendVerificationCodeBySMS(contact);
      }

      isLoading.value = false;

      if (success) {
        // Show success message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Código de verificação enviado para ${isEmailSelected.value ? 'seu email' : 'seu telefone'}!',
              ),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to verification screen
          context.go(
            '/verify-code',
            extra: {'contact': contact, 'contactType': contactType},
          );
        }
      } else {
        errorMessage.value = 'Erro ao enviar código de verificação. Tente novamente.';
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Erro inesperado. Tente novamente.';
    }
  }
}