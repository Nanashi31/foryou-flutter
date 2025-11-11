import 'package:app_foryou/features/login/domain/entities/client.dart';

/// Abstracción del repositorio para el login.
/// Define el contrato que la capa de datos debe implementar.
abstract class LoginRepository {
  Future<Client> login(String email, String password);
  Future<void> signInWithOtp(String email);
}
