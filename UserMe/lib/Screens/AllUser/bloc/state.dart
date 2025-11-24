import '../model/allUser_model.dart';

enum Status { none, success, busy, failed }

class getAllUsersAppState {
  final Status status;
  final AllUsersModel? allusers;
  // final List<String>? moreData;
  // final bool hasReachedMax;

  getAllUsersAppState({
    this.status = Status.none,
    this.allusers,
    // this.moreData,
    // this.hasReachedMax = false,
  });

  getAllUsersAppState copyWith({
    Status? status,
    AllUsersModel? allusers,
    List<String>? moreData,
    bool? hasReachedMax,
  }) {
    return getAllUsersAppState(
      status: status ?? this.status,
      allusers: allusers ?? this.allusers,
      // moreData: moreData ?? this.moreData,
      // hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class InitialState extends getAllUsersAppState {}
