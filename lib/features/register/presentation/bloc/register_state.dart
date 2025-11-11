import 'package:equatable/equatable.dart';
import 'package:app_foryou/features/register/domain/entities/client.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final Client client;

  const RegisterSuccess({required this.client});

  @override
  List<Object> get props => [client];
}

class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure({required this.error});

  @override
  List<Object> get props => [error];
}
