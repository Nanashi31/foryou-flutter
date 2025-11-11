part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

/// Evento que se dispara cuando el usuario presiona el botón de iniciar sesión.
class LoginButtonPressed extends LoginEvent {
  final String email; // Cambiado de 'username' a 'email'.
  final String password;

  const LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

/// Evento que se dispara cuando el usuario solicita un enlace de inicio de sesión OTP.
class LoginWithOtpRequested extends LoginEvent {
  final String email;

  const LoginWithOtpRequested({required this.email});

  @override
  List<Object> get props => [email];
}
