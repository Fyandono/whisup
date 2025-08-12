// lib/features/whisp_field/cubit/whisp_hint_cubit.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class WhispLabelCubit extends Cubit<String> {
  WhispLabelCubit() : super(_hints.first) {
    _startCycling();
  }

  static const List<String> _hints = [
    "Let it out...",
    "Drop a thought…",
    "What's on your mind?",
    "Say it out loud…",
    "Share your feels 💬",
    "Relate to this?",
  ];

  int _index = 0;
  Timer? _timer;

  void _startCycling() {
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      _index = (_index + 1) % _hints.length;
      emit(_hints[_index]);
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
