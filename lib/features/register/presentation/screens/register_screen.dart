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
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            // En caso de éxito, se navega a la pantalla que indica al
            // usuario que verifique su correo.
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/verify-email', (route) => false);
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error en el registro: ${state.error}'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is RegisterLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const RegisterForm();
        },
      ),
    );
  }
}

/// Widget que contiene el formulario de registro completo.
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
                if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                  return 'El nombre solo puede contener letras y espacios';
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
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'El teléfono solo puede contener números';
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
