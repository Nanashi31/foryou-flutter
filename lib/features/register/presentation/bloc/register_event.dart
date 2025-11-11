import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String nombre;
  final String usuario;
  final String email;
  final String password;
  final String telefono;
  final String domicilio;

  const RegisterSubmitted({
    required this.nombre,
    required this.usuario,
    required this.email,
    required this.password,
    required this.telefono,
    required this.domicilio,
  });

  @override
  List<Object> get props => [nombre, usuario, email, password, telefono, domicilio];
}
