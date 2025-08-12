part of 'create_username_bloc.dart';

sealed class CreateUsernameEvent extends Equatable {
  const CreateUsernameEvent();

  @override
  List<Object> get props => [];
}

final class LoadCreateUsername extends CreateUsernameEvent {
    final void Function() onLoadWhisps;
  
    const LoadCreateUsername({
      required this.onLoadWhisps,
    });

  @override
  List<Object> get props => [onLoadWhisps];
}

final class UpdateUsername extends CreateUsernameEvent {
  final String value;
  
    const UpdateUsername({
      required this.value,
    });

  @override
  List<Object> get props => [value];
}

final class CreateUsernamePost extends CreateUsernameEvent {
   final void Function() onSuccess;
  
    const CreateUsernamePost({
      required this.onSuccess,
    });

  @override
  List<Object> get props => [onSuccess];
}