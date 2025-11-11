import 'package:app_foryou/core/config/supabase_config.dart';
import 'package:app_foryou/features/home/presentation/home_page.dart';
import 'package:app_foryou/features/login/data/datasources/login_remote_datasource.dart';
import 'package:app_foryou/features/login/data/repositories/login_repository_impl.dart';
import 'package:app_foryou/features/login/domain/usecases/login_client_usecase.dart';
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
  // 1. Asegura que los bindings de Flutter estén inicializados.
  // Es necesario para poder llamar a código nativo antes de runApp().
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inicializa Supabase.
  // Aquí configuramos el cliente de Supabase con la URL y la clave anónima.
  // Usamos la clase `SupabaseConfig` para mantener las credenciales centralizadas.
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );

  // 3. Inicia la aplicación Flutter.
  runApp(const MyApp());
}

/// Cliente global de Supabase para un fácil acceso en toda la app.
///
/// Esta instancia nos permite interactuar con Supabase Auth, Database, etc.
/// desde cualquier parte de la aplicación sin tener que pasar la instancia
/// manualmente.
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
        // 4. Selección de la pantalla inicial basada en el estado de autenticación.
        // Usamos un StreamBuilder que escucha los cambios en el estado de
        // autenticación de Supabase (`onAuthStateChange`).
        home: StreamBuilder<AuthState>(
          stream: supabase.auth.onAuthStateChange,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }

            final session = snapshot.data?.session;
            if (session != null) {
              return const HomePage();
            } else {
              return const EmailVerificationScreen();
            }
          },
        ),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
