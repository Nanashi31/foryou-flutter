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
      // Step 1: Sign up the user in Supabase Auth.
      final authResponse = await _supabase.auth.signUp(
        email: params.email,
        password: params.password,
      );

      if (authResponse.user == null) {
        throw Exception(
            'Fallo en el registro: el usuario no fue creado en el sistema de autenticación.');
      }

      final user = authResponse.user!;

      // Step 2: Update the profile in 'clientes' and select it in one atomic operation.
      // The trigger 'on_auth_user_created' should have already created a row.
      // We just need to fill in the rest of the details.
      final profileData = {
        'nombre': params.nombre,
        'usuario': params.usuario,
        'telefono': params.telefono,
        'domicilio': params.domicilio,
      };

      // Use a chained query to update and then immediately select the updated row.
      final updatedProfile = await _supabase
          .from('clientes')
          .update(profileData)
          .eq('id_cliente', user.id)
          .select()
          .single();

      return ClientModel.fromJson(updatedProfile);

    } on AuthException catch (e) {
      if (e.message.toLowerCase().contains('user already registered')) {
        throw Exception('Esta cuenta ya esta registrada. Intentelo de nuevo.');
      }
      throw Exception('Error de autenticación durante el registro: ${e.message}');
    } on PostgrestException catch (e) {
      // This error now strongly implies a missing or incorrect RLS policy.
      throw Exception(
          'La cuenta fue creada, pero falló al guardar el perfil: ${e.message}');
    } catch (e) {
      throw Exception(
          'Ocurrió un error inesperado durante el registro: ${e.toString()}');
    }
  }
}
