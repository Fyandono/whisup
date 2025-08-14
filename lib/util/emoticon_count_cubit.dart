import 'package:flutter_bloc/flutter_bloc.dart';

class EmoticonCountState {
  final Map<String, int> counts;
  final String? selectedEmoji; // emoji the user has chosen (null if none)

  EmoticonCountState({required this.counts, this.selectedEmoji});

  EmoticonCountState copyWith({
    Map<String, int>? counts,
    String? selectedEmoji,
  }) {
    return EmoticonCountState(
      counts: counts ?? this.counts,
      selectedEmoji: selectedEmoji,
    );
  }
}

class EmoticonCountCubit extends Cubit<EmoticonCountState> {
  EmoticonCountCubit(Map<String, int> initialCounts)
    : super(EmoticonCountState(counts: Map<String, int>.from(initialCounts)));

  void react(String emoji) {
    final updated = Map<String, int>.from(state.counts);

    // If tapping the same emoji → unreact
    if (state.selectedEmoji == emoji) {
      updated[emoji] = (updated[emoji] ?? 0) - 1;
      emit(state.copyWith(counts: updated, selectedEmoji: null));
    }
    // If tapping a different emoji → switch reaction
    else {
      // Remove prev reaction
      if (state.selectedEmoji != null) {
        updated[state.selectedEmoji!] =
            (updated[state.selectedEmoji!] ?? 0) - 1;
      }
      // Add new reaction
      updated[emoji] = (updated[emoji] ?? 0) + 1;
      emit(state.copyWith(counts: updated, selectedEmoji: emoji));
    }
  }
}
