import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository.dart';
import 'event.dart';
import 'state.dart';

class UserDetailsBloc extends Bloc<UserDetailsBlocEvent, UserDetailsAppState> {
  final Repository repository;
  UserDetailsBloc({required this.repository}) : super(InitialState()) {
    on<UserDetailsEvent>(onUserDetails);
    on<EditUserDetailsEvent>(onEditUserDetails);
    on<AddUserEvent>(onAddUserDetails);
  }
  Future<void> onUserDetails(
    UserDetailsEvent event,
    Emitter<UserDetailsAppState> emit,
  ) async {
    emit(state.copyWith(status: UserDetailsStatus.busy));
    try {
      final user = await repository.getUserDetails();

      emit(state.copyWith(status: UserDetailsStatus.busy));
      user.when(
        success: (data) {
          emit(
            state.copyWith(
              status: UserDetailsStatus.success,
              userdetails: data,
            ),
          );
        },
        failure: (error) {
          emit(state.copyWith(status: UserDetailsStatus.failed));
        },
      );
      emit(state.copyWith(status: UserDetailsStatus.none));
    } catch (e) {
      emit(state.copyWith(status: UserDetailsStatus.busy));
      emit(state.copyWith(status: UserDetailsStatus.failed));
    }
  }

  Future<void> onEditUserDetails(
    EditUserDetailsEvent event,
    Emitter<UserDetailsAppState> emit,
  ) async {
    emit(state.copyWith(status: UserDetailsStatus.busy));
    try {
      final user = await repository.editUserDetails(
        id: event.id,
        params: event.params,
      );

      emit(state.copyWith(status: UserDetailsStatus.busy));
      user.when(
        success: (data) {
          emit(
            state.copyWith(
              status: UserDetailsStatus.success,
              userdetails: data,
            ),
          );
        },
        failure: (error) {
          emit(state.copyWith(status: UserDetailsStatus.failed));
        },
      );
      emit(state.copyWith(status: UserDetailsStatus.none));
    } catch (e) {
      emit(state.copyWith(status: UserDetailsStatus.busy));
      emit(state.copyWith(status: UserDetailsStatus.failed));
    }
  }

  Future<void> onAddUserDetails(
    AddUserEvent event,
    Emitter<UserDetailsAppState> emit,
  ) async {
    emit(state.copyWith(status: UserDetailsStatus.busy));
    try {
      final user = await repository.addUserDetails(params: event.params);

      emit(state.copyWith(status: UserDetailsStatus.busy));
      user.when(
        success: (data) {
          emit(
            state.copyWith(
              status: UserDetailsStatus.success,
              userdetails: data,
            ),
          );
        },
        failure: (error) {
          emit(state.copyWith(status: UserDetailsStatus.failed));
        },
      );
      emit(state.copyWith(status: UserDetailsStatus.none));
    } catch (e) {
      emit(state.copyWith(status: UserDetailsStatus.busy));
      emit(state.copyWith(status: UserDetailsStatus.failed));
    }
  }
}
