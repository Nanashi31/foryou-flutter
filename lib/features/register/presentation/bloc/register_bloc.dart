import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_foryou/features/register/domain/repositories/client_repository.dart';
import 'package:app_foryou/features/register/domain/usecases/register_client_usecase.dart';
import 'package:app_foryou/features/register/presentation/bloc/register_event.dart';
import 'package:app_foryou/features/register/presentation/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterClientUseCase _registerClientUseCase;

  RegisterBloc(this._registerClientUseCase) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  void _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final client = await _registerClientUseCase(
        RegisterParams(
          nombre: event.nombre,
          usuario: event.usuario,
          email: event.email,
          password: event.password,
          telefono: event.telefono,
          domicilio: event.domicilio,
        ),
      );
      emit(RegisterSuccess(client: client));
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }
}
