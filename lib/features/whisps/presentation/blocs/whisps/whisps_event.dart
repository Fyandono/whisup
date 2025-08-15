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

class AddWhisp extends WhispsEvent {
  final String message;
    const AddWhisp({
      required this.message
    });

  @override
  List<Object> get props => [message];
}
