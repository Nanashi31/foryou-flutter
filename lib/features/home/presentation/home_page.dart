import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Pantalla principal que se muestra solo a usuarios autenticados.
/// Muestra un mensaje de bienvenida y un botón para cerrar sesión.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _supabase = Supabase.instance.client;
  User? _user;

  @override
  void initState() {
    super.initState();
    // Obtenemos la información del usuario actual al iniciar la pantalla.
    // Esto es seguro porque esta pantalla solo es accesible si hay una sesión activa.
    _user = _supabase.auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Principal'),
        actions: [
          // Añadimos un botón de cierre de sesión directamente en la AppBar.
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
            onPressed: () async {
              // Lógica para cerrar sesión.
              try {
                // `signOut` elimina la sesión local del usuario y revoca el token
                // de acceso en el servidor de Supabase.
                await _supabase.auth.signOut();

                // Una vez que `signOut` se completa, el StreamBuilder en `main.dart`
                // que escucha `onAuthStateChange` detectará que la sesión es nula.
                // Automáticamente, reconstruirá la UI y mostrará `LoginScreen`
                // sin necesidad de navegación manual con `Navigator`.
              } catch (e) {
                // Manejo de errores en caso de que el cierre de sesión falle.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error al cerrar sesión: ${e.toString()}'),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // Mostramos el email del usuario si está disponible.
              '¡Bienvenido!',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              _user?.email ?? 'No se pudo cargar el email',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
