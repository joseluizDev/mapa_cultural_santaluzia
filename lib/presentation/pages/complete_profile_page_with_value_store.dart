import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_cultural_santaluzia/core/state/value_store.dart';
import 'package:mapa_cultural_santaluzia/domain/usecases/login_usecase.dart';
import 'package:mapa_cultural_santaluzia/domain/usecases/register_usecase.dart';
import 'package:mapa_cultural_santaluzia/presentation/pages/complete_profile_page.dart';
import 'package:mapa_cultural_santaluzia/presentation/stores/auth_value_store.dart';

typedef CompleteProfileCallback =
    void Function({
      required String name,
      required String cpf,
      required String age,
      required String city,
      required String description,
      required List<String> activities,
    });

class CompleteProfilePageWithValueStore extends StatefulWidget {
  final String contact;
  final String contactType;

  const CompleteProfilePageWithValueStore({
    super.key,
    required this.contact,
    required this.contactType,
  });

  @override
  State<CompleteProfilePageWithValueStore> createState() =>
      _CompleteProfilePageWithValueStoreState();
}

class _CompleteProfilePageWithValueStoreState
    extends State<CompleteProfilePageWithValueStore> {
  late AuthValueStore _authStore;

  @override
  void initState() {
    super.initState();
    // Initialize the store with necessary use cases
    _authStore = AuthValueStore(
      loginUseCase: LoginUseCase(),
      registerUseCase: RegisterUseCase(),
    );

    // Set the verification contact information and code verified state
    _authStore.setSuccess(
      AuthState(
        verificationContact: widget.contact,
        verificationContactType: widget.contactType,
        isVerificationSent: true,
        isCodeVerified: true,
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
      // When there's an error, show the complete profile page with the error message
      errorBuilder: (context, message) {
        // Show the error snackbar after the build is complete
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        });
        return _buildCompleteProfilePageContent();
      },
      // When successful (profile completed or not)
      builder: (context, authState) {
        // If user is logged in with complete profile, navigate to home
        if (authState.user != null && authState.user!.isProfileComplete) {
          // Navigate to home after the build is complete
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/home');
          });
          // Show loading while navigation happens
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Otherwise, show the complete profile page
        return _buildCompleteProfilePageContent();
      },
    );
  }

  Widget _buildCompleteProfilePageContent() {
    // Use the original CompleteProfilePage but with our store
    return CompleteProfilePage(
      contact: widget.contact,
      contactType: widget.contactType,
      onCompleteProfile:
          ({
            required String name,
            required String cpf,
            required String age,
            required String city,
            required String description,
            required List<String> activities,
          }) {
            _authStore.completeProfile(
              name: name,
              cpf: cpf,
              age: age,
              city: city,
              description: description,
              activities: activities,
            );
          },
    );
  }
}
