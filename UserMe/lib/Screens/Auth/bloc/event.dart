import 'package:meta/meta.dart';

@immutable
abstract class BlocEvent {}

class UserEvent extends BlocEvent {
  final String username;
  final String password;
  UserEvent({required this.username, required this.password});
}
