import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:whisup/util/secure_storage.dart';

part 'pixel_avatar_event.dart';
part 'pixel_avatar_state.dart';

class PixelAvatarBloc extends Bloc<PixelAvatarEvent, PixelAvatarState> {
  final Map<String, Color> _coloredPixels = {};
  Color _selectedColor = Colors.black;

  PixelAvatarBloc() : super(PixelAvatarInitial()) {
    on<PixelAvatarStarted>((event, emit) {
      _coloredPixels.clear();
      _selectedColor = Colors.black;
      emit(
        PixelAvatarLoaded(
          coloredPixels: Map.from(_coloredPixels),
          selectedColor: _selectedColor,
        ),
      );
    });

    on<PixelAvatarPixelToggled>((event, emit) {
      final key = '${event.x}_${event.y}';
      if (_coloredPixels.containsKey(key)) {
        _coloredPixels.remove(key);
      } else {
        _coloredPixels[key] = _selectedColor;
      }
      emit(
        PixelAvatarLoaded(
          coloredPixels: Map.from(_coloredPixels),
          selectedColor: _selectedColor,
        ),
      );
    });

    on<PixelAvatarColorChanged>((event, emit) {
      _selectedColor = event.color;
      emit(
        PixelAvatarLoaded(
          coloredPixels: Map.from(_coloredPixels),
          selectedColor: _selectedColor,
        ),
      );
    });

    on<PixelAvatarReset>((event, emit) {
      _coloredPixels.clear();
      emit(
        PixelAvatarLoaded(
          coloredPixels: Map.from(_coloredPixels),
          selectedColor: _selectedColor,
        ),
      );
    });

    on<PixelAvatarSave>((event, emit) {
      final savedData =
          _coloredPixels.entries
              .map((e) => '${e.key}:${e.value.toARGB32().toRadixString(16)}')
              .toList();
      
      // Optional: emit a separate Saved state or just log/save/send
      storageController.write("pixel_avatar", jsonEncode(savedData));
    
      event.onSuccess();
      
      // Re-emit current loaded state if needed
      emit(
        PixelAvatarLoaded(
          coloredPixels: Map.from(_coloredPixels),
          selectedColor: _selectedColor,
        ),
      );
    });
  }
}
