import 'package:app_foryou/features/login/data/datasources/login_remote_datasource.dart';
import 'package:app_foryou/features/login/domain/entities/client.dart';
import 'package:app_foryou/features/login/domain/repositories/login_repository.dart';

/// Implementación del repositorio de login.
/// Conecta el origen de datos (remoto o local) con el caso de uso.
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Client> login(String email, String password) async {
    // Simplemente pasa la llamada al origen de datos remoto.
    return await remoteDataSource.login(email, password);
  }
}
