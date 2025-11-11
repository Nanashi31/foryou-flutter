part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final Client client;

  const LoginSuccess({required this.client});

  @override
  List<Object> get props => [client];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}

/// Estado que indica que el enlace de inicio de sesión OTP ha sido enviado.
class LoginOtpLinkSent extends LoginState {}
