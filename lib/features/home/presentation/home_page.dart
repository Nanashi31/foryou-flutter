import 'package:app_foryou/features/home/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Pantalla principal que se muestra solo a usuarios autenticados.
/// Muestra un mensaje de bienvenida y un botón para cerrar sesión.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Al iniciar la pantalla, solicitamos al Bloc que cargue el perfil.
    context.read<ProfileBloc>().add(ProfileFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Principal'),
        actions: [
          // Botón de cierre de sesión.
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
            onPressed: () async {
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              final theme = Theme.of(context);
              try {
                // Al cerrar sesión, el StreamBuilder en main.dart se encargará
                // de redirigir a la pantalla de Login.
                await Supabase.instance.client.auth.signOut();
              } catch (e) {
                if (!mounted) return;
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('Error al cerrar sesión: ${e.toString()}'),
                    backgroundColor: theme.colorScheme.error,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadInProgress || state is ProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileLoadSuccess) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¡Bienvenido!',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.profile.nombre,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          }
          if (state is ProfileLoadFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error al cargar el perfil: ${state.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return const Center(child: Text('Estado inesperado.'));
        },
      ),
    );
  }
}
