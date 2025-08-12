part of 'create_username_bloc.dart';

sealed class CreateUsernameState extends Equatable {
  const CreateUsernameState();

  @override
  List<Object> get props => [];
}

final class CreateUsernameInitial extends CreateUsernameState {}

final class CreateUsernameInitialForm extends CreateUsernameState {}

final class CreateUsernameLooksGood extends CreateUsernameState {}

final class CreateUsernameAlreadyTaken extends CreateUsernameState {}

final class CreateUsernameNotValid extends CreateUsernameState {}

final class CreateUsernameChecking extends CreateUsernameState {}

final class CreateUsernamePosting extends CreateUsernameState {}

final class CreateUsernameError extends CreateUsernameState {
  final String errorMessage;
  const CreateUsernameError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class CreateUsernameErrorPosting extends CreateUsernameState {
  final String errorMessage;
  const CreateUsernameErrorPosting({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class CreateUsernameErrorGettingDeviceId extends CreateUsernameState {
  final String errorMessage;
  const CreateUsernameErrorGettingDeviceId({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
