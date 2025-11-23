import '../model/user_res_model.dart';

enum UserDetailsStatus { none, success, busy, failed }

class UserDetailsAppState {
  final UserDetailsStatus status;
  final UserResModel? userdetails;

  UserDetailsAppState({this.status = UserDetailsStatus.none, this.userdetails});

  UserDetailsAppState copyWith({
    UserDetailsStatus? status,
    UserResModel? userdetails,
  }) {
    return UserDetailsAppState(
      status: status ?? this.status,
      userdetails: userdetails ?? this.userdetails,
    );
  }
}

class InitialState extends UserDetailsAppState {}
