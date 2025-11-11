import 'package:app_foryou/features/login/domain/entities/client.dart';
import 'package:app_foryou/features/login/domain/repositories/login_repository.dart';

/// Caso de uso para el inicio de sesión de un cliente.
/// Contiene la lógica de negocio, como validaciones, antes de llamar al repositorio.
class LoginClientUseCase {
  final LoginRepository repository;

  LoginClientUseCase(this.repository);

  /// Ejecuta el caso de uso.
  Future<Client> call(String email, String password) {
    // Ejemplo de lógica de negocio: validar la contraseña.
    if (password.length < 6) {
      // Supabase por defecto requiere 6 caracteres, no 8.
      throw Exception('La contraseña debe tener al menos 6 caracteres.');
    }
    // Llama al método del repositorio para realizar el login.
    return repository.login(email, password);
  }
}
