import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app_foryou/features/login/domain/entities/client.dart';
import 'package:app_foryou/features/login/domain/usecases/login_client_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

/// BLoC para gestionar el estado de la pantalla de login.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginClientUseCase loginClientUseCase;

  LoginBloc({required this.loginClientUseCase}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      // Al recibir el evento, emitimos el estado de carga.
      emit(LoginLoading());
      try {
        // Llamamos al caso de uso con el email y la contraseña.
        final client = await loginClientUseCase(event.email, event.password);
        // Si tiene éxito, emitimos el estado de éxito.
        emit(LoginSuccess(client: client));
      } catch (e) {
        // Si falla, emitimos el estado de fallo con el mensaje de error.
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
