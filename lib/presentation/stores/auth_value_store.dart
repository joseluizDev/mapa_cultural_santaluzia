import 'package:mapa_cultural_santaluzia/core/state/value_store.dart';
import 'package:mapa_cultural_santaluzia/domain/entities/user.dart';
import 'package:mapa_cultural_santaluzia/domain/usecases/login_usecase.dart';
import 'package:mapa_cultural_santaluzia/domain/usecases/register_usecase.dart';

// Define states for Auth process
class AuthState {
  final User? user;
  final String? verificationContact;
  final String? verificationContactType;
  final bool isVerificationSent;
  final bool isCodeVerified;
  final String? errorMessage;

  AuthState({
    this.user,
    this.verificationContact,
    this.verificationContactType,
    this.isVerificationSent = false,
    this.isCodeVerified = false,
    this.errorMessage,
  });

  AuthState copyWith({
    User? user,
    String? verificationContact,
    String? verificationContactType,
    bool? isVerificationSent,
    bool? isCodeVerified,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      verificationContact: verificationContact ?? this.verificationContact,
      verificationContactType:
          verificationContactType ?? this.verificationContactType,
      isVerificationSent: isVerificationSent ?? this.isVerificationSent,
      isCodeVerified: isCodeVerified ?? this.isCodeVerified,
      errorMessage: errorMessage,
    );
  }
}

class AuthValueStore extends Store<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthValueStore({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       super();

  // Check if user is logged in
  bool get isLoggedIn => value.data?.user != null;

  // Getter for current user
  User? get currentUser => value.data?.user;

  // Start the login process by sending a verification code
  Future<void> sendLoginVerificationCode(
    String contact,
    String contactType,
  ) async {
    setLoading();

    try {
      final success = await _loginUseCase.sendVerificationCode(
        contact,
        contactType,
      );

      if (success) {
        final newState = AuthState(
          verificationContact: contact,
          verificationContactType: contactType,
          isVerificationSent: true,
          user: value.data?.user,
        );
        setSuccess(newState);
      } else {
        setError('Erro ao enviar código de verificação. Tente novamente.');
      }
    } catch (e) {
      setError('Erro inesperado: ${e.toString()}', error: e);
    }
  }

  // Start the registration process by sending a verification code
  Future<void> sendRegisterVerificationCode(
    String contact,
    String contactType,
  ) async {
    setLoading();

    try {
      final success = await _registerUseCase.sendVerificationCode(
        contact,
        contactType,
      );

      if (success) {
        final newState = AuthState(
          verificationContact: contact,
          verificationContactType: contactType,
          isVerificationSent: true,
          user: value.data?.user,
        );
        setSuccess(newState);
      } else {
        setError('Erro ao enviar código de verificação. Tente novamente.');
      }
    } catch (e) {
      setError('Erro inesperado: ${e.toString()}', error: e);
    }
  }

  // Verify the code that was sent
  Future<void> verifyCode(String code) async {
    setLoading();

    try {
      final success = await _loginUseCase.verifyCode(code);

      if (success) {
        final newState = AuthState(
          verificationContact: value.data?.verificationContact,
          verificationContactType: value.data?.verificationContactType,
          isVerificationSent: value.data?.isVerificationSent ?? false,
          isCodeVerified: true,
          user: value.data?.user,
        );
        setSuccess(newState);
      } else {
        setError('Código inválido. Tente novamente.');
      }
    } catch (e) {
      setError('Erro inesperado: ${e.toString()}', error: e);
    }
  }

  // Complete the login process after verification
  Future<void> completeLogin() async {
    if (value.data?.verificationContact == null ||
        value.data?.verificationContactType == null) {
      setError('Informações de contato não disponíveis.');
      return;
    }

    setLoading();

    try {
      final user = await _loginUseCase.login(
        value.data!.verificationContact!,
        value.data!.verificationContactType!,
      );

      if (user != null) {
        final newState = AuthState(
          user: user,
          verificationContact: value.data?.verificationContact,
          verificationContactType: value.data?.verificationContactType,
          isVerificationSent: value.data?.isVerificationSent ?? false,
          isCodeVerified: value.data?.isCodeVerified ?? false,
        );
        setSuccess(newState);
      } else {
        setError('Erro ao fazer login. Tente novamente.');
      }
    } catch (e) {
      setError('Erro inesperado: ${e.toString()}', error: e);
    }
  }

  // Complete user profile registration
  Future<void> completeProfile({
    required String name,
    required String cpf,
    required String age,
    required String city,
    required String description,
    required List<String> activities,
  }) async {
    if (value.data?.verificationContact == null ||
        value.data?.verificationContactType == null) {
      setError('Informações de contato não disponíveis.');
      return;
    }

    setLoading();

    try {
      final user = await _registerUseCase.register(
        contact: value.data!.verificationContact!,
        contactType: value.data!.verificationContactType!,
        name: name,
        cpf: cpf,
        age: age,
        city: city,
        description: description,
        activities: activities,
      );

      if (user != null) {
        final newState = AuthState(
          user: user,
          verificationContact: value.data?.verificationContact,
          verificationContactType: value.data?.verificationContactType,
          isVerificationSent: value.data?.isVerificationSent ?? false,
          isCodeVerified: value.data?.isCodeVerified ?? false,
        );
        setSuccess(newState);
      } else {
        setError('Erro ao completar o registro. Tente novamente.');
      }
    } catch (e) {
      setError('Erro inesperado: ${e.toString()}', error: e);
    }
  }

  // Logout user
  void logout() {
    setInitial();
  }

  // Reset verification state
  void resetVerification() {
    final newState = AuthState(user: value.data?.user);
    setSuccess(newState);
  }
}
