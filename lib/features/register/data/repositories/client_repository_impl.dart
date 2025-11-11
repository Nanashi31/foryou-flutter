import 'package:app_foryou/features/register/data/datasources/client_local_datasource.dart';
import 'package:app_foryou/features/register/data/datasources/client_remote_datasource.dart';
import 'package:app_foryou/features/register/domain/entities/client.dart';
import 'package:app_foryou/features/register/domain/repositories/client_repository.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientRemoteDataSource remoteDataSource;
  final ClientLocalDataSource localDataSource;

  ClientRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Client> registerClient(RegisterParams params) async {
    final clientModel = await remoteDataSource.registerClient(params);
    await localDataSource.cacheClient(clientModel);
    return clientModel;
  }
}
