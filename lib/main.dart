import 'package:app_foryou/features/home/presentation/home_page.dart';
import 'package:app_foryou/features/login/data/datasources/login_remote_datasource.dart';
import 'package:app_foryou/features/login/data/repositories/login_repository_impl.dart';
import 'package:app_foryou/features/login/domain/usecases/login_client_usecase.dart';
import 'package:app_foryou/features/login/presentation/bloc/login_bloc.dart';
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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_foryou/core/data/local/app_database.dart';

// Punto de entrada principal de la aplicación.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

/// Cliente global de Supabase para un fácil acceso en toda la app.
final supabase = Supabase.instance.client;

/// Widget raíz de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos MultiBlocProvider para proveer todos los Blocs a la aplicación.
    // Esto centraliza la inyección de dependencias de los Blocs.
    return MultiBlocProvider(
      providers: [
        // Proveedor para el Bloc de Login.
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            loginClientUseCase: LoginClientUseCase(
              LoginRepositoryImpl(
                remoteDataSource: LoginRemoteDataSourceImpl(),
              ),
            ),
          ),
        ),
        // Proveedor para el Bloc de Registro.
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
      ],
      child: MaterialApp(
        title: 'ForYou App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // La pantalla de inicio sigue siendo nuestro StreamBuilder reactivo.
        home: StreamBuilder<AuthState>(
          stream: supabase.auth.onAuthStateChange,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData && snapshot.data!.session != null) {
              return const HomePage();
            }
            // Si no hay sesión, por defecto mostramos la pantalla de login.
            return const LoginScreen();
          },
        ),
        // Definimos las rutas nombradas para la navegación.
        routes: {
          // No necesitamos una ruta para Home, ya que el StreamBuilder nos lleva allí.
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
        },
      ),
    );
  }
}
