import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_cultural_santaluzia/core/state/value_store.dart';
import 'package:mapa_cultural_santaluzia/domain/usecases/login_usecase.dart';
import 'package:mapa_cultural_santaluzia/domain/usecases/register_usecase.dart';
import 'package:mapa_cultural_santaluzia/presentation/pages/register_page.dart';
import 'package:mapa_cultural_santaluzia/presentation/stores/auth_value_store.dart';

typedef RegisterCallback = void Function(String contact, String contactType);

class RegisterPageWithValueStore extends StatefulWidget {
  const RegisterPageWithValueStore({super.key});

  @override
  State<RegisterPageWithValueStore> createState() =>
      _RegisterPageWithValueStoreState();
}

class _RegisterPageWithValueStoreState
    extends State<RegisterPageWithValueStore> {
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
      // When in initial state, show the register page
      initialBuilder: (context) => _buildRegisterPageContent(),
      // When loading, show a loading indicator
      loadingBuilder: (context) =>
          Scaffold(body: Center(child: CircularProgressIndicator())),
      // When there's an error, show the register page with the error message
      errorBuilder: (context, message) {
        // Show the error snackbar after the build is complete
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        });
        return _buildRegisterPageContent();
      },
      // When successful (sent verification code or registered)
      builder: (context, authState) {
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

        // Otherwise, show the register page
        return _buildRegisterPageContent();
      },
    );
  }

  Widget _buildRegisterPageContent() {
    // Use the original RegisterPage but with our store
    return RegisterPage(
      onRegister: (contact, contactType) {
        _authStore.sendRegisterVerificationCode(contact, contactType);
      },
    );
  }
}
