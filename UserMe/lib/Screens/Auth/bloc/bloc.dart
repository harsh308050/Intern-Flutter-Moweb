import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository.dart';
import 'event.dart';
import 'state.dart';

class UserBloc extends Bloc<BlocEvent, AppState> {
  final Repository repository;
  UserBloc({required this.repository}) : super(InitialState()) {
    on<UserEvent>(onLoginUser);
  }
  Future<void> onLoginUser(UserEvent event, Emitter<AppState> emit) async {
    emit(state.copyWith(status: Status.busy));
    try {
      final user = await repository.loginUser(
        username: event.username,
        password: event.password,
      );

      emit(state.copyWith(status: Status.busy));
      user.when(
        success: (data) {
          emit(state.copyWith(status: Status.success, user: data));
        },
        failure: (error) {
          emit(state.copyWith(status: Status.failed));
        },
      );
      emit(state.copyWith(status: Status.none));
    } catch (e) {
      emit(state.copyWith(status: Status.busy));
      emit(state.copyWith(status: Status.failed));
    }
  }
}
