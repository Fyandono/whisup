part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final String username;
  final Map<String, Color> pixelAvatar;
    const ProfileLoaded({
      required this.username,
      required this.pixelAvatar,
    });
  
  @override
  List<Object> get props => [username, pixelAvatar];
}

final class ProfileError extends ProfileState {}
