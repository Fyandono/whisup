part of 'react_bloc.dart';

sealed class ReactState extends Equatable {
  const ReactState();
  
  @override
  List<Object> get props => [];
}

final class ReactInitial extends ReactState {}


