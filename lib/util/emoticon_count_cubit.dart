import 'package:flutter_bloc/flutter_bloc.dart';

class EmoticonCountCubit extends Cubit<Map<String, int>> {
  EmoticonCountCubit(Map<String, int> initialCounts)
      : super(Map<String, int>.from(initialCounts));

  void increment(String emoji) {
    final updated = Map<String, int>.from(state);
    updated[emoji] = (updated[emoji] ?? 0) + 1;
    emit(updated);
  }

  void decrement(String emoji) {
    final updated = Map<String, int>.from(state);
    if ((updated[emoji] ?? 0) > 0) {
      updated[emoji] = updated[emoji]! - 1;
    }
    emit(updated);
  }
}