import '../model/user_model.dart';

enum Status { none, success, busy, failed }

class AppState {
  final Status status;
  final UserModel? user;

  AppState({this.status = Status.none, this.user});

  AppState copyWith({Status? status, UserModel? user}) {
    return AppState(status: status ?? this.status, user: user ?? this.user);
  }
}

class InitialState extends AppState {}
