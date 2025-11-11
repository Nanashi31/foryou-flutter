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

        // **VERIFICACIÓN DE CORREO ELECTRÓNICO**
        // Comprobamos si el correo del usuario ha sido verificado.
        // `emailConfirmedAt` es una fecha en formato string si está confirmado,
        // o `null` si no lo está.
        if (user.emailConfirmedAt == null) {
          // Si el correo no está confirmado, lanzamos una excepción
          // para notificar al usuario.
          // También es buena práctica cerrar la sesión que se acaba de abrir.
          await _supabase.auth.signOut();
          throw Exception(
            'Por favor, verifica tu correo electrónico antes de iniciar sesión. '
            'Revisa tu bandeja de entrada.',
          );
        }

        // Si el correo está verificado, procedemos a obtener el perfil del cliente.
        // Buscamos en la tabla 'clientes' el perfil que corresponde al ID del usuario.
        final profileResponse = await _supabase
            .from('clientes')
            .select()
            .eq('id_cliente', user.id)
            .single(); // Usamos .single() para obtener un único registro.

        // Devolvemos el perfil del cliente convertido a nuestro modelo.
        return ClientModel.fromJson(profileResponse);
        
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
