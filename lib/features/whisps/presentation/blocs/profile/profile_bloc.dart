import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:whisup/features/whisps/data/repository/repository.dart';
import 'package:whisup/util/device_identifier.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    final whispsRepository = WhispsRepository();

    on<LoadProfile>((event, emit) async {
      try {
        final deviceId = await DeviceIdentifier.getDeviceID();
        final response = await whispsRepository.getProfile(deviceId);
        emit(
          ProfileLoaded(
            username: response['username'],
            pixelAvatar: response['pixel_avatar'],
          ),
        );
      } catch (e) {
        emit(ProfileError());
      }
    });
  }
}
