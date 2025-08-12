import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'react_event.dart';
part 'react_state.dart';

class ReactBloc extends Bloc<ReactEvent, ReactState> {
  ReactBloc() : super(ReactInitial()) {
    on<ReactEmoji>((event, emit) async {
    });

    on<ReactComment>((event, emit) async {
      
    });
  }
}
