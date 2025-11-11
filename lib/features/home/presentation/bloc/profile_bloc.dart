import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app_foryou/features/home/domain/usecases/get_profile_usecase.dart';
import 'package:app_foryou/features/login/domain/entities/client.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileBloc({required this.getProfileUseCase}) : super(ProfileInitial()) {
    on<ProfileFetched>((event, emit) async {
      emit(ProfileLoadInProgress());
      try {
        final profile = await getProfileUseCase();
        emit(ProfileLoadSuccess(profile: profile));
      } catch (e) {
        emit(ProfileLoadFailure(error: e.toString()));
      }
    });
  }
}
