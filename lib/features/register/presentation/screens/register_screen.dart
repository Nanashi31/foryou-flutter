import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_foryou/features/register/presentation/bloc/register_bloc.dart';
import 'package:app_foryou/features/register/presentation/bloc/register_event.dart';
import 'package:app_foryou/features/register/presentation/bloc/register_state.dart';

/// Pantalla de registro de nuevos usuarios.
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
      ),
      // Usamos BlocConsumer para reaccionar a cambios de estado (ej: mostrar SnackBar)
      // y para reconstruir la UI (ej: mostrar un spinner).
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            // En caso de éxito, mostramos un mensaje de confirmación.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('¡Registro exitoso! Por favor, inicia sesión.'),
                backgroundColor: Colors.green,
              ),
            );
            // Y luego, enviamos al usuario de vuelta a la pantalla de login.
            // Usamos popAndPushNamed para reemplazar la pantalla actual por la de login.
            Navigator.of(context).popAndPushNamed('/login');
          } else if (state is RegisterFailure) {
            // En caso de fallo, mostramos el error.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error en el registro: ${state.error}'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          // Mientras se registra, mostramos un indicador de progreso.
          if (state is RegisterLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // Por defecto, mostramos el formulario de registro.
          return const RegisterForm();
        },
      ),
    );
  }
}

/// Widget que contiene el formulario de registro.
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _usuarioController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _domicilioController = TextEditingController();

  @override
  void dispose() {
    // Es buena práctica limpiar los controladores cuando el widget se destruye.
    _nombreController.dispose();
    _usuarioController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _telefonoController.dispose();
    _domicilioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre Completo'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce tu nombre';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _usuarioController,
              decoration: const InputDecoration(labelText: 'Nombre de usuario'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce un nombre de usuario';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Por favor, introduce un email válido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'La contraseña debe tener al menos 6 caracteres';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _telefonoController,
              decoration: const InputDecoration(labelText: 'Teléfono'),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce tu teléfono';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _domicilioController,
              decoration: const InputDecoration(labelText: 'Domicilio'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce tu domicilio';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Si el formulario es válido, disparamos el evento al BLoC.
                if (_formKey.currentState!.validate()) {
                  context.read<RegisterBloc>().add(
                        RegisterSubmitted(
                          nombre: _nombreController.text,
                          usuario: _usuarioController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          telefono: _telefonoController.text,
                          domicilio: _domicilioController.text,
                        ),
                      );
                }
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
