import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_foryou/features/login/presentation/bloc/login_bloc.dart';
import 'package:app_foryou/features/login/presentation/screens/login_success_screen.dart';

/// Pantalla de inicio de sesión.
/// Contiene un formulario para email y contraseña.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      // BlocConsumer es ideal aquí: combina un listener para efectos secundarios (como SnackBars)
      // y un builder para reconstruir la UI según el estado.
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          // Si el estado es de fallo, mostramos un SnackBar con el error.
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          } else if (state is LoginSuccess) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (state is LoginOtpLinkSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('¡Enlace de inicio de sesión enviado! Revisa tu correo.'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          // Si el estado es de carga, mostramos un indicador de progreso.
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // En cualquier otro caso, mostramos el formulario.
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.contains('@')) {
                          return 'Por favor, introduce un email válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduce tu contraseña';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        // Validamos el formulario antes de enviar el evento al Bloc.
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(
                                LoginButtonPressed(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        }
                      },
                      child: const Text('Iniciar Sesión'),
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {
                        // Navegamos a la pantalla de registro usando la ruta nombrada.
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text('¿No tienes cuenta? Regístrate'),
                    ),
                    const SizedBox(height: 8.0),
                    TextButton(
                      onPressed: () {
                        // Solo validamos el campo de email para esta acción.
                        if (_emailController.text.isNotEmpty && _emailController.text.contains('@')) {
                          context.read<LoginBloc>().add(
                                LoginWithOtpRequested(email: _emailController.text),
                              );
                        } else {
                          // Mostramos un error si el email no es válido.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Por favor, introduce un email válido para recibir el enlace.'),
                              backgroundColor: Theme.of(context).colorScheme.error,
                            ),
                          );
                        }
                      },
                      child: const Text('O inicia sesión con un enlace mágico'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
