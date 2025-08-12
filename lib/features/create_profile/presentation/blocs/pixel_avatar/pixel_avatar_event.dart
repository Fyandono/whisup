part of 'pixel_avatar_bloc.dart';

sealed class PixelAvatarEvent extends Equatable {
  const PixelAvatarEvent();

  @override
  List<Object> get props => [];
}

final class PixelAvatarStarted extends PixelAvatarEvent {}

final class PixelAvatarPixelToggled extends PixelAvatarEvent {
  final int x;
  final int y;

  const PixelAvatarPixelToggled({required this.x, required this.y});

  @override
  List<Object> get props => [x, y];
}

final class PixelAvatarColorChanged extends PixelAvatarEvent {
  final Color color;

  const PixelAvatarColorChanged(this.color);

  @override
  List<Object> get props => [color];
}

final class PixelAvatarReset extends PixelAvatarEvent {}

final class PixelAvatarSave extends PixelAvatarEvent {
  final void Function() onSuccess;

  const PixelAvatarSave({required this.onSuccess});

  @override
  List<Object> get props => [onSuccess];
}
