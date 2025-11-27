enum Status { success, busy, failed }

class ConnectivityState {
  final Status status;
  ConnectivityState({this.status = Status.busy});

  ConnectivityState copyWith({Status? status}) {
    return ConnectivityState(status: status ?? this.status);
  }
}

class ConnectionInitialState extends ConnectivityState {}
