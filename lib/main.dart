import 'package:app_foryou/features/login/data/datasources/login_remote_datasource.dart';
import 'package:app_foryou/features/login/data/repositories/login_repository_impl.dart';
import 'package:app_foryou/features/login/domain/usecases/login_client_usecase.dart';
import 'package:app_foryou/features/login/presentation/bloc/login_bloc.dart';
import 'package:app_foryou/features/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (context) => LoginBloc(
          loginClientUseCase: LoginClientUseCase(
            LoginRepositoryImpl(
              remoteDataSource: LoginRemoteDataSourceImpl(
                client: http.Client(),
              ),
            ),
          ),
        ),
        child: const LoginScreen(),
      ),
    );
  }
}
