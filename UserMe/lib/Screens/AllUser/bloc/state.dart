import '../model/allUser_model.dart';

enum Status { none, success, busy, failed }

class getAllUsersAppState {
  final Status status;
  final AllUsersModel? allusers;
  final Status? loadMore;

  getAllUsersAppState({
    this.status = Status.none,
    this.allusers,
    this.loadMore = Status.none,
  });

  getAllUsersAppState copyWith({
    Status? status,
    AllUsersModel? allusers,
    Status? loadMore,
  }) {
    return getAllUsersAppState(
      status: status ?? this.status,
      allusers: allusers ?? this.allusers,
      loadMore: loadMore ?? this.loadMore,
    );
  }
}

class InitialState extends getAllUsersAppState {}
