import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'event.dart';
import 'state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectivityState> {
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  ConnectionBloc() : super(ConnectionInitialState()) {
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      final isConnected =
          result.isNotEmpty && !result.contains(ConnectivityResult.none);

      add(ConnectivityChanged(isConnected: isConnected));
    });

    on<ConnectivityChanged>(onConnectivityChanged);
  }

  Future<void> onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<ConnectivityState> emit,
  ) async {
    emit(state.copyWith(status: Status.busy));

    if (event.isConnected) {
      emit(state.copyWith(status: Status.success));
    } else {
      emit(state.copyWith(status: Status.failed));
    }
  }
}
