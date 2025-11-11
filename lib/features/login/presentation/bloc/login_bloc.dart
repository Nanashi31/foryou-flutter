import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app_foryou/features/login/domain/entities/client.dart';
import 'package:app_foryou/features/login/domain/usecases/login_client_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginClientUseCase loginClientUseCase;

  LoginBloc({required this.loginClientUseCase}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final client = await loginClientUseCase(event.username, event.password);
        emit(LoginSuccess(client: client));
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
