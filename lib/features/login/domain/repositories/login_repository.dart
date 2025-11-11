import 'package:app_foryou/features/login/domain/entities/client.dart';

abstract class LoginRepository {
  Future<Client> login(String username, String password);
}
