import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'base_store.dart';

class VerificationCodeStore extends BaseStore with LoadingState, ErrorState {
  // Resend functionality notifiers
  late final ValueNotifier<bool> canResend = register(ValueNotifier(false));
  late final ValueNotifier<int> resendCountdown = register(ValueNotifier(60));
  
  Timer? _timer;
  final String contact;
  final String contactType;

  VerificationCodeStore({
    required this.contact,
    required this.contactType,
  }) {
    // Register loading and error notifiers for automatic disposal
    register(isLoading);
    register(errorMessage);
    _startResendTimer();
  }

  /// Start the resend countdown timer
  void _startResendTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value = resendCountdown.value - 1;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  /// Format contact for display
  String formatContact() {
    if (contactType == 'email') {
      return contact;
    } else {
      // Format phone number
      if (contact.length >= 10) {
        final cleaned = contact.replaceAll(RegExp(r'\D'), '');
        return '(${cleaned.substring(0, 2)}) ${cleaned.substring(2, 7)}-${cleaned.substring(7)}';
      }
      return contact;
    }
  }

  /// Verify the entered code
  void verifyCode(List<String> codeDigits, BuildContext context) {
    final code = codeDigits.join();

    if (code.length != 4) {
      errorMessage.value = 'Por favor, digite todos os 4 dígitos do código';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    // Simulate verification
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      // For demonstration, accept any code that ends with "0"
      if (code.endsWith('0')) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Código verificado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          
          // Navigate to complete profile
          context.go(
            '/complete-profile',
            extra: {
              'contact': contact,
              'contactType': contactType,
            },
          );
        }
      } else {
        errorMessage.value = 'Código inválido. Tente novamente.';
      }
    });
  }

  /// Resend verification code
  void resendCode(BuildContext context) {
    canResend.value = false;
    resendCountdown.value = 60;
    _startResendTimer();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Código reenviado para ${formatContact()}'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}