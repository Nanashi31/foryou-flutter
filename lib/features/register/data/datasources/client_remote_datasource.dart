import 'package:app_foryou/features/register/data/models/client_model.dart';
import 'package:app_foryou/features/register/domain/repositories/client_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Abstracción del origen de datos remoto para el registro de clientes.
abstract class ClientRemoteDataSource {
  /// Registra un nuevo cliente en el sistema.
  ///
  /// Primero, crea el usuario en Supabase Auth.
  /// Luego, guarda la información del perfil en la tabla 'clientes'.
  Future<ClientModel> registerClient(RegisterParams params);
}

/// Implementación del origen de datos para el registro usando Supabase.
class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  // Usamos la instancia global del cliente de Supabase.
  final _supabase = Supabase.instance.client;

  @override
  Future<ClientModel> registerClient(RegisterParams params) async {
    try {
      // 1. Registrar el usuario en el sistema de autenticación de Supabase.
      final authResponse = await _supabase.auth.signUp(
        email: params.email,
        password: params.password,
      );

      // Si el registro en Auth fue exitoso y tenemos un usuario, procedemos.
      if (authResponse.user == null) {
        // Esto es poco probable si no hubo excepción, pero es una buena práctica verificar.
        throw Exception('Fallo en el registro: el usuario no fue creado en el sistema de autenticación.');
      }

      final userId = authResponse.user!.id;

      // 2. Insertar los datos del perfil en la tabla 'clientes'.
      // Esta tabla debe tener una política de RLS que permita a los usuarios recién creados
      // insertar su propio perfil.
      final response = await _supabase.from('clientes').insert({
        'id_cliente': userId, // Vinculado al id del usuario en 'auth.users'.
        'nombre': params.nombre,
        'usuario': params.usuario,
        'correo': params.email,
        'telefono': params.telefono,
        'domicilio': params.domicilio,
      }).select(); // .select() devuelve el registro recién creado.

      // Si la inserción fue exitosa, 'response' contendrá una lista con el nuevo cliente.
      if (response.isEmpty) {
        // Si la inserción no devolvió datos, algo salió mal.
        throw Exception('Fallo en el registro: no se pudo guardar el perfil del usuario.');
      }

      // Convertimos el resultado a nuestro modelo y lo devolvemos.
      return ClientModel.fromJson(response.first);

    } on AuthException catch (e) {
      // Capturamos errores específicos de la autenticación (ej: email ya en uso).
      throw Exception('Error de registro: ${e.message}');
    } catch (e) {
      // Capturamos cualquier otro error.
      throw Exception('Ocurrió un error inesperado durante el registro: ${e.toString()}');
    }
  }
}
