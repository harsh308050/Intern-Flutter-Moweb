import 'package:meta/meta.dart';

@immutable
abstract class UserDetailsBlocEvent {}

class UserDetailsEvent extends UserDetailsBlocEvent {}

class EditUserDetailsEvent extends UserDetailsBlocEvent {
  final String id;
  final Map<String, dynamic> params;

  EditUserDetailsEvent({required this.id, required this.params});
}

class AddUserEvent extends UserDetailsBlocEvent {
  final Map<String, dynamic> params;

  AddUserEvent({required this.params});
}
