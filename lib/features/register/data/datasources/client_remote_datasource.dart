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
      final authResponse = await _supabase.auth.signUp(
        email: params.email,
        password: params.password,
      );

      if (authResponse.user == null) {
        throw Exception('Fallo en el registro: el usuario no fue creado en el sistema de autenticación.');
      }

      final userId = authResponse.user!.id;

      // ** PUNTO CRÍTICO **
      // La siguiente operación fallará si la columna 'id_cliente' en tu tabla 'clientes'
      // no es de tipo 'uuid'. Este es el error 'invalid input for type bigint' que has visto.
      // Asegúrate de que el tipo de la columna en tu base de datos de Supabase sea 'uuid'.
      final response = await _supabase.from('clientes').insert({
        'id_cliente': userId,
        'nombre': params.nombre,
        'usuario': params.usuario,
        'correo': params.email,
        'telefono': params.telefono,
        'domicilio': params.domicilio,
      }).select();

      final rows = List<Map<String, dynamic>>.from(response);
      if (rows.isEmpty) {
        throw Exception('Fallo en el registro: no se pudo guardar el perfil del usuario. Revisa los permisos (RLS) de tu tabla.');
      }

      return ClientModel.fromJson(rows.first);

    } on AuthException catch (e) {
      throw Exception('Error de registro: ${e.message}');
    } catch (e) {
      throw Exception('Ocurrió un error inesperado durante el registro: ${e.toString()}');
    }
  }
}
