import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonStateNotifier extends StateNotifier<String> {
  ButtonStateNotifier() : super('All');  // Initialiser avec 'All'

  void selectButton(String buttonText) {
    state = buttonText;
  }
}

final buttonStateProvider = StateNotifierProvider<ButtonStateNotifier, String>((ref) {
  return ButtonStateNotifier();
});
