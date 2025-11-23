import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository.dart';
import 'event.dart';
import 'state.dart';

class AllUsersBloc extends Bloc<BlocEvent, getAllUsersAppState> {
  final Repository repository;
  AllUsersBloc({required this.repository}) : super(InitialState()) {
    on<getAllUsersEvent>(onGetAllUsers);
    on<getAllUsersDetailsEvent>(onGetAllUsersDetails);
  }
  Future<void> onGetAllUsers(
    getAllUsersEvent event,
    Emitter<getAllUsersAppState> emit,
  ) async {
    emit(state.copyWith(status: Status.busy));
    try {
      final allusers = await repository.getAllUsers();

      emit(state.copyWith(status: Status.busy));
      allusers.when(
        success: (data) {
          emit(state.copyWith(status: Status.success, allusers: data));
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

  Future<void> onGetAllUsersDetails(
    getAllUsersDetailsEvent event,
    Emitter<getAllUsersAppState> emit,
  ) async {
    emit(state.copyWith(status: Status.busy));
    try {
      final allusers = await repository.getAllUsersDetailsData(event.id);

      emit(state.copyWith(status: Status.busy));
      allusers.when(
        success: (data) {
          emit(state.copyWith(status: Status.success, allusers: data));
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
