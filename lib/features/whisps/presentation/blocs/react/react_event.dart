part of 'react_bloc.dart';

sealed class ReactEvent extends Equatable {
  const ReactEvent();

  @override
  List<Object> get props => [];
}

final class ReactEmoji extends ReactEvent {
  final int id;
  final String emoji;
  const ReactEmoji({required this.id, required this.emoji});

  @override
  List<Object> get props => [id, emoji];
}

final class ReactComment extends ReactEvent {
  final int id;
  final String comment;
  const ReactComment({required this.id, required this.comment});

  @override
  List<Object> get props => [id, comment];
}
