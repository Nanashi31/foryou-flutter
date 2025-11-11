import 'package:app_foryou/features/login/data/datasources/login_remote_datasource.dart';
import 'package:app_foryou/features/login/domain/entities/client.dart';
import 'package:app_foryou/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Client> login(String username, String password) async {
    return await remoteDataSource.login(username, password);
  }
}
