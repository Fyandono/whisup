part of 'whisps_bloc.dart';

sealed class WhispsState extends Equatable {
  const WhispsState();

  @override
  List<Object> get props => [];
}

final class WhispsInitial extends WhispsState {}

final class WhispsLoading extends WhispsState {}

final class WhispsLoaded extends WhispsState {
  final List<CardWhispModel> listObject;
  final bool hasMore;

  const WhispsLoaded({required this.listObject, required this.hasMore});

  @override
  List<Object> get props => [listObject, hasMore];
}

final class WhispsError extends WhispsState {}
