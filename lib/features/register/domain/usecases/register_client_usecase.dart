import 'package:app_foryou/features/register/domain/entities/client.dart';
import 'package:app_foryou/features/register/domain/repositories/client_repository.dart';

class RegisterClientUseCase {
  final ClientRepository repository;

  RegisterClientUseCase(this.repository);

  Future<Client> call(RegisterParams params) {
    return repository.registerClient(params);
  }
}
