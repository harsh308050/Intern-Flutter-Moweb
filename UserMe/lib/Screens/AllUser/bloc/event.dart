import 'package:meta/meta.dart';

@immutable
abstract class BlocEvent {}

class getAllUsersEvent extends BlocEvent {
  final String? query;
  final String? order;
  final bool? isTyping;
  final int? skip;

  getAllUsersEvent({this.query, this.order, this.isTyping, this.skip});
}

class getAllUsersDetailsEvent extends BlocEvent {
  final num id;
  getAllUsersDetailsEvent({required this.id});
}
