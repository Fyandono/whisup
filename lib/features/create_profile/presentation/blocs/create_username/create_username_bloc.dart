import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whisup/features/create_profile/data/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:whisup/util/device_identifier.dart';
import 'package:whisup/util/secure_storage.dart';

part 'create_username_event.dart';
part 'create_username_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}

class CreateUsernameBloc
    extends Bloc<CreateUsernameEvent, CreateUsernameState> {
  CreateUsernameBloc() : super(CreateUsernameInitial()) {
    // Repository
    final CreateUsernameRepository createUsernameRepository =
        CreateUsernameRepository();

    bool usernameAlreadyTaken = false;
    String deviceId = "";
    String username = "";

    bool validator(String value) {
      final validUsername = RegExp(r'^[a-z0-9_]{5,20}$');
      if (!validUsername.hasMatch(value)) {
        return false;
      }
      return true;
    }

    on<LoadCreateUsername>((event, emit) async {
      try {
        deviceId = await DeviceIdentifier.getDeviceID();
        username = await createUsernameRepository.getUsernameFromDeviceId(deviceId);
        if (username.isNotEmpty) {
            event.onLoadWhisps();
        }
      } catch (e) {
        emit(CreateUsernameErrorGettingDeviceId(errorMessage: "We couldn't verify your device ID. Please try again on a real device."));
      }
    });

    on<UpdateUsername>((event, emit) async {
      username = event.value;

      if (username.isNotEmpty) {
        if (validator(username)) {
          try {
            emit(CreateUsernameChecking());
            usernameAlreadyTaken = await createUsernameRepository
                .getIsUsernameTaken(username);
          } catch (e) {
            emit(
              CreateUsernameError(
                errorMessage:
                    "Couldn’t check your username. Mind giving it another shot?",
              ),
            );
          }

          if (usernameAlreadyTaken) {
            emit(CreateUsernameAlreadyTaken());
          } else {
            emit(CreateUsernameLooksGood());
          }
        } else {
          emit(CreateUsernameNotValid());
        }
      } else {
        emit(CreateUsernameInitialForm());
      }
    }, transformer: debounce(const Duration(milliseconds: 400)));

    on<CreateUsernamePost>((event, emit) async {
      try {
        // check username avail again
        if (validator(username)) {
          try {
            emit(CreateUsernamePosting());
            usernameAlreadyTaken = await createUsernameRepository
                .getIsUsernameTaken(username);
          } catch (e) {
            emit(
              CreateUsernameError(
                errorMessage:
                    "Couldn't check your username. Mind giving it another shot?",
              ),
            );
          }

          // if (usernameAlreadyTaken) {
            // emit(CreateUsernameAlreadyTaken());
          // } else {
            // post username to db
            await storageController.write("username", username);
            // on success
            event.onSuccess();
            emit(CreateUsernameLooksGood());
          // }
        } else {
          emit(CreateUsernameNotValid());
        }
      } catch (e) {
        // Failed to post or something so try again later
        emit(
          CreateUsernameErrorPosting(
            errorMessage:
                "Couldn't save your username. Mind giving it another shot?",
          ),
        );
      }
    });
  }
}
