part of 'whisps_bloc.dart';

sealed class WhispsEvent extends Equatable {
  const WhispsEvent();

  @override
  List<Object> get props => [];
}

class LoadWhisps extends WhispsEvent {
  @override
  List<Object> get props => [];
}

class LoadMoreWhisps extends WhispsEvent {}

class RefreshWhisps extends WhispsEvent {}
