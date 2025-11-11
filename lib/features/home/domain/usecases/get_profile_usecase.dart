import 'package:app_foryou/features/home/domain/repositories/profile_repository.dart';
import 'package:app_foryou/features/login/domain/entities/client.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Client> call() {
    return repository.getProfile();
  }
}
