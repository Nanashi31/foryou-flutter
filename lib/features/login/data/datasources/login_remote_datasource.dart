import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_foryou/features/login/data/models/client_model.dart';

// Abstracción del origen de datos remoto para el login.
abstract class LoginRemoteDataSource {
  /// Autentica a un usuario con su email y contraseña.
  /// Devuelve un [ClientModel] en caso de éxito.
  /// Lanza una [Exception] en caso de fallo.
  Future<ClientModel> login(String email, String password);

  /// Envía un enlace de inicio de sesión (OTP) al correo electrónico del usuario.
  Future<void> signInWithOtp(String email);
}

// Implementación del origen de datos remoto que utiliza Supabase.
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  // Ya no necesitamos http.Client, ahora usamos el cliente global de Supabase.
  final _supabase = Supabase.instance.client;

  @override
  Future<void> signInWithOtp(String email) async {
    try {
      await _supabase.auth.signInWithOtp(
        email: email,
        emailRedirectTo: 'foryou.app://auth-callback/',
      );
    } on AuthException catch (e) {
      throw Exception('Error al enviar el enlace de inicio de sesión: ${e.message}');
    } catch (e) {
      throw Exception('Ocurrió un error inesperado: ${e.toString()}');
    }
  }

  @override
  Future<ClientModel> login(String email, String password) async {
    try {
      // Limpiamos los datos de entrada para evitar errores comunes.
      final cleanEmail = email.trim().toLowerCase();
      final cleanPassword = password.trim();

      // Usamos el método de Supabase para iniciar sesión con email y contraseña.
      final authResponse = await _supabase.auth.signInWithPassword(
        email: cleanEmail,
        password: cleanPassword,
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
            .maybeSingle(); // Usamos .maybeSingle() para evitar la excepción si no hay perfil.

        if (profileResponse == null) {
          // Si no se encuentra el perfil, es un estado inconsistente.
          // Cerramos la sesión para evitar problemas.
          await _supabase.auth.signOut();
          throw Exception('No se pudo encontrar el perfil del usuario. Por favor, contacta a soporte.');
        }

        // Devolvemos el perfil del cliente convertido a nuestro modelo.
        return ClientModel.fromJson(profileResponse);
        
      } else {
        // Si por alguna razón no hay un objeto User, lanzamos un error.
        throw Exception('Inicio de sesión fallido: no se recibieron datos del usuario.');
      }
    } on AuthException catch (e) {
      // Capturamos excepciones específicas de Supabase Auth.
      // Si el error es por credenciales inválidas, a menudo el problema real
      // es que el correo del usuario no ha sido verificado.
      if (e.message.toLowerCase().contains('invalid login credentials')) {
        throw Exception(
            'Credenciales inválidas. Asegúrate de que el correo y la contraseña son correctos y que el correo ha sido verificado.');
      }
      // Para otros errores, mostramos el mensaje original.
      throw Exception('Error de autenticación: ${e.message}');
    } catch (e) {
      // Capturamos cualquier otro error inesperado.
      throw Exception('Ocurrió un error inesperado: ${e.toString()}');
    }
  }
}
