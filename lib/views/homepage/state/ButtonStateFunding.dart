import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonStateFunding extends StateNotifier<String> {
  ButtonStateFunding() : super('All');

  void selectButton(String buttonText) {
    state = buttonText;
  }
}

final buttonStateProvider = StateNotifierProvider<ButtonStateFunding, String>((ref) {
  return ButtonStateFunding();
});
