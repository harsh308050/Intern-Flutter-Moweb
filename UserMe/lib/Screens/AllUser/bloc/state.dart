import '../model/allUser_model.dart';

enum Status { none, success, busy, failed }

class getAllUsersAppState {
  final Status status;
  final AllUsersModel? allusers;

  getAllUsersAppState({this.status = Status.none, this.allusers});

  getAllUsersAppState copyWith({Status? status, AllUsersModel? allusers}) {
    return getAllUsersAppState(
      status: status ?? this.status,
      allusers: allusers ?? this.allusers,
    );
  }
}

class InitialState extends getAllUsersAppState {}
