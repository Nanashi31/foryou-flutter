import 'package:app_foryou/features/new_request/data/models/detalles_solicitud_model.dart';
import 'package:app_foryou/features/new_request/data/models/solicitud_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewRequestRepository {
  final SupabaseClient _supabaseClient;

  NewRequestRepository(this._supabaseClient);

  Future<void> createRequest({
    required SolicitudModel solicitud,
    required double? height,
    required double? width,
  }) async {
    try {
      // Step 1: Insert into 'solicitudes' and get the new row's ID
      final response = await _supabaseClient
          .from('solicitudes')
          .insert(solicitud.toJson())
          .select('id_solicitud')
          .single();

      final newRequestId = response['id_solicitud'];

      if (newRequestId == null) {
        throw Exception('Failed to get new request ID');
      }

      // Step 2: Insert into 'detalles_solicitud' using the new ID
      final detalles = DetallesSolicitudModel(
        idSolicitud: newRequestId,
        medAlt: height,
        medAnc: width,
      );

      await _supabaseClient.from('detalles_solicitud').insert(detalles.toJson());

    } catch (e) {
      // Handle exceptions, e.g., log them or show an error to the user
      print('Error creating request: $e');
      rethrow;
    }
  }
}
