part of 'pixel_avatar_bloc.dart';

sealed class PixelAvatarState extends Equatable {
  @override
  List<Object> get props => [];
}

final class PixelAvatarInitial extends PixelAvatarState {}

final class PixelAvatarLoaded extends PixelAvatarState {
  final Map<String, Color> coloredPixels;
  final Color selectedColor;

  PixelAvatarLoaded({required this.coloredPixels, required this.selectedColor});

  @override
  List<Object> get props => [coloredPixels, selectedColor];
}
