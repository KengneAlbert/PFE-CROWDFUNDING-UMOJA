import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonBookmarkState extends StateNotifier<String> {
  ButtonBookmarkState() : super('All');  // Initialiser avec 'All'

  void selectButton(String buttonText) {
    state = buttonText;
  }
}

final buttonBookmarkStateProvider = StateNotifierProvider<ButtonBookmarkState, String>((ref) {
  return ButtonBookmarkState();
});
