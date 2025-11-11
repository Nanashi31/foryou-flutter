import 'package:app_foryou/features/register/domain/entities/client.dart';
import 'package:app_foryou/features/register/domain/repositories/client_repository.dart';

class RegisterClientUseCase {
  final ClientRepository repository;

  RegisterClientUseCase(this.repository);

  Future<Client> call(RegisterParams params) {
    if (!params.email.contains('@')) {
      throw Exception('Email not valid');
    }
    if (params.password.length < 8) {
      throw Exception('Password too short');
    }
    return repository.registerClient(params);
  }
}
