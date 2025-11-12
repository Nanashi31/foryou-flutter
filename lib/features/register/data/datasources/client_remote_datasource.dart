import 'package:app_foryou/features/register/data/models/client_model.dart';
import 'package:app_foryou/features/register/domain/repositories/client_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ClientRemoteDataSource {
  Future<ClientModel> registerClient(RegisterParams params);
}

class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<ClientModel> registerClient(RegisterParams params) async {
    try {
      // Paso 1: Registrar el usuario en Supabase Auth, solo con email y contraseña.
      final authResponse = await _supabase.auth.signUp(
        email: params.email,
        password: params.password,
      );

      if (authResponse.user == null) {
        throw Exception(
            'Fallo en el registro: el usuario no fue creado en el sistema de autenticación.');
      }

      final user = authResponse.user!;

      // Paso 2: Insertar explícitamente el perfil en la tabla 'clientes'.
      // Esto es más robusto y fiable que depender de un trigger en la base de datos.
      final profileData = {
        'id_cliente': user.id, // Vincula el perfil con el usuario de auth.
        'nombre': params.nombre,
        'usuario': params.usuario,
        'correo': params.email,
        'telefono': params.telefono,
        'domicilio': params.domicilio,
      };

      // Usamos .insert() para crear el registro.
      await _supabase.from('clientes').insert(profileData);

      // Ahora, recupera el perfil que acabamos de insertar para devolverlo.
      // Usamos .single() porque sabemos que debe existir exactamente un perfil.
      final newProfile = await _supabase
          .from('clientes')
          .select()
          .eq('id_cliente', user.id)
          .single();

      // Devolvemos el perfil del cliente recién creado y parseado a nuestro modelo.
      return ClientModel.fromJson(newProfile);

    } on AuthException catch (e) {
      // Manejo de errores de autenticación, como un usuario ya existente.
      if (e.message.toLowerCase().contains('user already registered')) {
        throw Exception('Esta cuenta ya esta registrada. Intentelo de nuevo.');
      }
      throw Exception('Error de autenticación durante el registro: ${e.message}');
    } on PostgrestException catch (e) {
      // Manejo de errores de la base de datos, por si falla la inserción del perfil.
      // En un futuro, se podría añadir lógica para eliminar el usuario de auth si esto falla.
      throw Exception(
          'La cuenta fue creada, pero falló al guardar el perfil: ${e.message}');
    } catch (e) {
      // Captura de cualquier otro error inesperado.
      throw Exception(
          'Ocurrió un error inesperado durante el registro: ${e.toString()}');
    }
  }
}
