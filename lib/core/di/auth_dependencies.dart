import 'package:mapa_cultural_santaluzia/domain/usecases/login_usecase.dart';
import 'package:mapa_cultural_santaluzia/domain/usecases/register_usecase.dart';
import 'package:mapa_cultural_santaluzia/presentation/stores/auth_value_store.dart';

class AuthDependencies {
  static AuthValueStore provideAuthValueStore() {
    return AuthValueStore(
      loginUseCase: LoginUseCase(),
      registerUseCase: RegisterUseCase(),
    );
  }
}
