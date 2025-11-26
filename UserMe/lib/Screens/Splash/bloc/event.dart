import 'package:meta/meta.dart';

@immutable
abstract class ConnectionEvent {}

class ConnectivityChanged extends ConnectionEvent {
  final bool isConnected;
  ConnectivityChanged({required this.isConnected});
}
