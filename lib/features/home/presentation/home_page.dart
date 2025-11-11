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
    _user = _supabase.auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // Mostramos el email del usuario si está disponible.
              'Bienvenido, ${_user?.email ?? 'Usuario'}!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Lógica para cerrar sesión.
                try {
                  await _supabase.auth.signOut();
                } catch (e) {
                  // Manejo de errores en caso de que el cierre de sesión falle.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error al cerrar sesión: ${e.toString()}'),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
                // Una vez que signOut se completa, el StreamBuilder en main.dart
                // detectará el cambio de estado y redirigirá a la pantalla de login.
                // No es necesario navegar manualmente si la UI reacciona al estado.
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
