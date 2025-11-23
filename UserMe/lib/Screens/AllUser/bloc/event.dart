import 'package:meta/meta.dart';

@immutable
abstract class BlocEvent {}

class getAllUsersEvent extends BlocEvent {}

class getAllUsersDetailsEvent extends BlocEvent {
  final num id;
  getAllUsersDetailsEvent({required this.id});
}
