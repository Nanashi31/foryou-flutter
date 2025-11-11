import 'package:app_foryou/core/data/local/app_database.dart';
import 'package:app_foryou/features/register/data/models/client_model.dart';

abstract class ClientLocalDataSource {
  Future<void> cacheClient(ClientModel client);
}

class ClientLocalDataSourceImpl implements ClientLocalDataSource {
  final AppDatabase database;

  ClientLocalDataSourceImpl({required this.database});

  @override
  Future<void> cacheClient(ClientModel client) async {
    await database.into(database.clientes).insert(
          ClientesCompanion.insert(
            idCliente: client.idCliente,
            nombre: client.nombre,
            usuario: client.usuario,
            telefono: client.telefono,
            domicilio: client.domicilio,
            correo: client.correo,
          ),
        );
  }
}
