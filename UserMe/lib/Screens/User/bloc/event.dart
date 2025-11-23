import 'package:meta/meta.dart';

@immutable
abstract class UserDetailsBlocEvent {}

class UserDetailsEvent extends UserDetailsBlocEvent {}

class EditUserDetailsEvent extends UserDetailsBlocEvent {
  final String id;
  final Map<String, dynamic> params;

  EditUserDetailsEvent({required this.id, required this.params});
}
