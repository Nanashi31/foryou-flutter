import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_foryou/features/login/data/models/client_model.dart';

// Abstracción del origen de datos remoto para el login.
abstract class LoginRemoteDataSource {
  /// Autentica a un usuario con su email y contraseña.
  /// Devuelve un [ClientModel] en caso de éxito.
  /// Lanza una [Exception] en caso de fallo.
  Future<ClientModel> login(String email, String password);
}

// Implementación del origen de datos remoto que utiliza Supabase.
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  // Ya no necesitamos http.Client, ahora usamos el cliente global de Supabase.
  final _supabase = Supabase.instance.client;

  @override
  Future<ClientModel> login(String email, String password) async {
    try {
      // Usamos el método de Supabase para iniciar sesión con email y contraseña.
      final authResponse = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // Si el inicio de sesión es exitoso y tenemos un usuario, procedemos.
      if (authResponse.user != null) {
        final user = authResponse.user!;

        // Creamos una instancia de ClientModel a partir de los datos del usuario de Supabase.
        // Como el login básico no nos da un "nombre", usamos la parte local del email como placeholder.
        // En una app real, estos datos vendrían de una tabla de "perfiles".
        return ClientModel(
          idCliente: user.id, // Usamos el ID de Supabase como String.
          nombre: user.email!.split('@').first, // Placeholder para el nombre.
          correo: user.email, // Usamos el email de Supabase.
        );
      } else {
        // Si por alguna razón no hay un objeto User, lanzamos un error.
        throw Exception('Inicio de sesión fallido: no se recibieron datos del usuario.');
      }
    } on AuthException catch (e) {
      // Capturamos excepciones específicas de Supabase Auth.
      // Devolvemos un mensaje más amigable para el usuario.
      throw Exception('Error de autenticación: ${e.message}');
    } catch (e) {
      // Capturamos cualquier otro error inesperado.
      throw Exception('Ocurrió un error inesperado: ${e.toString()}');
    }
  }
}
