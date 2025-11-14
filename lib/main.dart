import 'package:app_foryou/core/config/supabase_config.dart';
import 'package:app_foryou/features/home/data/datasources/profile_remote_datasource.dart';
import 'package:app_foryou/features/home/data/repositories/profile_repository_impl.dart';
import 'package:app_foryou/features/home/domain/usecases/get_profile_usecase.dart';
import 'package:app_foryou/features/home/presentation/bloc/profile_bloc.dart';
import 'package:app_foryou/features/home/presentation/screens/home_screen.dart';
import 'package:app_foryou/features/login/data/datasources/login_remote_datasource.dart';
import 'package:app_foryou/features/login/data/repositories/login_repository_impl.dart';
import 'package:app_foryou/features/login/domain/usecases/login_client_usecase.dart';
import 'package:app_foryou/features/login/domain/usecases/login_with_otp_usecase.dart';
import 'package:app_foryou/features/login/presentation/bloc/login_bloc.dart';
import 'package:app_foryou/features/login/presentation/screens/email_verification_screen.dart';
import 'package:app_foryou/features/login/presentation/screens/login_screen.dart';
import 'package:app_foryou/features/register/data/datasources/client_remote_datasource.dart';
import 'package:app_foryou/features/register/data/datasources/client_local_datasource.dart';
import 'package:app_foryou/features/register/data/repositories/client_repository_impl.dart';
import 'package:app_foryou/features/register/domain/usecases/register_client_usecase.dart';
import 'package:app_foryou/features/register/presentation/bloc/register_bloc.dart';
import 'package:app_foryou/features/register/presentation/screens/register_screen.dart';
import 'package:app_foryou/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_foryou/core/data/local/app_database.dart';

// Punto de entrada principal de la aplicación.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) {
            final loginRepository = LoginRepositoryImpl(
              remoteDataSource: LoginRemoteDataSourceImpl(),
            );
            return LoginBloc(
              loginClientUseCase: LoginClientUseCase(loginRepository),
              loginWithOtpUseCase: LoginWithOtpUseCase(loginRepository),
            );
          },
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
            RegisterClientUseCase(
              ClientRepositoryImpl(
                remoteDataSource: ClientRemoteDataSourceImpl(),
                localDataSource: ClientLocalDataSourceImpl(
                  database: AppDatabase(),
                ),
              ),
            ),
          ),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
            getProfileUseCase: GetProfileUseCase(
              ProfileRepositoryImpl(
                remoteDataSource: ProfileRemoteDataSourceImpl(),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'ForYou App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
          '/verify-email': (context) => const EmailVerificationScreen(),
        },
      ),
    );
  }
}