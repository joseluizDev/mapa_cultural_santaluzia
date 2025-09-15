import '../../core/state/value_store.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

/// Authentication store using ValueNotifier pattern
/// Handles login, registration and user state
class AuthStore extends Store<User> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthStore({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase;

  /// Login with email and password
  Future<void> login(String email, String password) async {
    await execute(
      () => _loginUseCase.execute(email: email, password: password),
    );
  }

  /// Register a new user
  Future<void> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    await execute(
      () => _registerUseCase.execute(
        name: name,
        email: email,
        password: password,
        phone: phone,
      ),
    );
  }

  /// Logout user
  void logout() {
    setInitial();
  }

  /// Check if user is logged in
  bool get isLoggedIn => isSuccess && data != null;

  /// Get current logged in user
  User? get currentUser => data;
}
