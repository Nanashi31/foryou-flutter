import 'package:app_foryou/features/register/data/models/client_model.dart';
import 'package:app_foryou/features/register/domain/repositories/client_repository.dart';
import 'package:supabase/supabase.dart';

abstract class ClientRemoteDataSource {
  Future<ClientModel> registerClient(RegisterParams params);
}

class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  final SupabaseClient supabase;

  ClientRemoteDataSourceImpl({required this.supabase});

  @override
  Future<ClientModel> registerClient(RegisterParams params) async {
    final authResponse = await supabase.auth.signUp(
      email: params.email,
      password: params.password,
    );

    if (authResponse.user == null) {
      throw Exception('Failed to register user');
    }

    final userId = authResponse.user!.id;

    final response = await supabase.from('clientes').insert({
      'id_cliente': userId,
      'nombre': params.nombre,
      'usuario': params.usuario,
      'correo': params.email,
      'telefono': params.telefono,
      'domicilio': params.domicilio,
    }).select();

    return ClientModel.fromJson(response.first);
  }
}
