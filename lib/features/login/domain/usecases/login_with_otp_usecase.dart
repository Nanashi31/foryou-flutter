import 'package:app_foryou/features/login/domain/repositories/login_repository.dart';

/// Caso de uso para iniciar sesión con OTP (One-Time Password).
class LoginWithOtpUseCase {
  final LoginRepository repository;

  LoginWithOtpUseCase(this.repository);

  /// Ejecuta el caso de uso.
  /// Llama al método del repositorio para enviar el enlace de OTP.
  Future<void> call(String email) async {
    return await repository.signInWithOtp(email);
  }
}
