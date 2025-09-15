import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_cultural_santaluzia/core/state/value_store.dart';
import 'package:mapa_cultural_santaluzia/domain/usecases/login_usecase.dart';
import 'package:mapa_cultural_santaluzia/domain/usecases/register_usecase.dart';
import 'package:mapa_cultural_santaluzia/presentation/pages/verification_code_page.dart';
import 'package:mapa_cultural_santaluzia/presentation/stores/auth_value_store.dart';

typedef VerifyCodeCallback = void Function(String code);

class VerificationCodePageWithValueStore extends StatefulWidget {
  final String contact;
  final String contactType;

  const VerificationCodePageWithValueStore({
    super.key,
    required this.contact,
    required this.contactType,
  });

  @override
  State<VerificationCodePageWithValueStore> createState() =>
      _VerificationCodePageWithValueStoreState();
}

class _VerificationCodePageWithValueStoreState
    extends State<VerificationCodePageWithValueStore> {
  late AuthValueStore _authStore;

  @override
  void initState() {
    super.initState();
    // Initialize the store with necessary use cases
    _authStore = AuthValueStore(
      loginUseCase: LoginUseCase(),
      registerUseCase: RegisterUseCase(),
    );

    // Set the verification contact information
    _authStore.setSuccess(
      AuthState(
        verificationContact: widget.contact,
        verificationContactType: widget.contactType,
        isVerificationSent: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConsumer<AuthState>(
      store: _authStore,
      // When loading, show a loading indicator
      loadingBuilder: (context) =>
          Scaffold(body: Center(child: CircularProgressIndicator())),
      // When there's an error, show the verification page with the error message
      errorBuilder: (context, message) {
        // Show the error snackbar after the build is complete
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        });
        return _buildVerificationPageContent();
      },
      // When successful (code verified or not)
      builder: (context, authState) {
        // If code is verified, navigate to complete profile or home
        if (authState.isCodeVerified) {
          // Navigate to complete profile after the build is complete
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (authState.user != null && authState.user!.isProfileComplete) {
              // If profile is already complete, go to home
              context.go('/home');
            } else {
              // If profile is not complete, go to complete profile
              context.go(
                '/complete-profile',
                extra: {
                  'contact': authState.verificationContact,
                  'contactType': authState.verificationContactType,
                },
              );
            }
          });
          // Show loading while navigation happens
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Otherwise, show the verification page
        return _buildVerificationPageContent();
      },
    );
  }

  Widget _buildVerificationPageContent() {
    // Use the original VerificationCodePage but with our store
    return VerificationCodePage(
      contact: widget.contact,
      contactType: widget.contactType,
      onVerify: (code) {
        _authStore.verifyCode(code);
      },
    );
  }
}
