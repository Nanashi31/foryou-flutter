import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_foryou/features/login/data/models/client_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ClientModel> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<ClientModel> getProfile() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('No user logged in');
      }

      final response = await _supabase
          .from('clientes')
          .select()
          .eq('id_cliente', userId)
          .single();

      return ClientModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get profile: ${e.toString()}');
    }
  }
}
