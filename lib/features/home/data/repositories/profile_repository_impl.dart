import 'package:app_foryou/features/home/data/datasources/profile_remote_datasource.dart';
import 'package:app_foryou/features/home/domain/repositories/profile_repository.dart';
import 'package:app_foryou/features/login/domain/entities/client.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Client> getProfile() async {
    return await remoteDataSource.getProfile();
  }
}
