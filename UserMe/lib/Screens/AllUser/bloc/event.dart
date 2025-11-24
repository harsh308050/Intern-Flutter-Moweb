import 'package:meta/meta.dart';

@immutable
abstract class BlocEvent {}

class getAllUsersEvent extends BlocEvent {
  final String? query;
  final String? order;
  final bool? isTyping;

  getAllUsersEvent({this.query, this.order, this.isTyping});
}

class getAllUsersDetailsEvent extends BlocEvent {
  final num id;
  getAllUsersDetailsEvent({required this.id});
}
