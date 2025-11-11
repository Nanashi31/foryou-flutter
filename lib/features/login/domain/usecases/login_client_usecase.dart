import 'package:app_foryou/features/login/domain/entities/client.dart';
import 'package:app_foryou/features/login/domain/repositories/login_repository.dart';

class LoginClientUseCase {
  final LoginRepository repository;

  LoginClientUseCase(this.repository);

  Future<Client> call(String username, String password) {
    if (password.length < 8) {
      throw Exception('Password must be at least 8 characters long.');
    }
    return repository.login(username, password);
  }
}
