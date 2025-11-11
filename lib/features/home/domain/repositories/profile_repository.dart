import 'package:app_foryou/features/login/domain/entities/client.dart';

abstract class ProfileRepository {
  Future<Client> getProfile();
}
