
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonStateIncomming extends StateNotifier<String> {
  ButtonStateIncomming() : super('All');

  void selectButton(String buttonText) {
    state = buttonText;
  }
}

final buttonStateProvider = StateNotifierProvider<ButtonStateIncomming, String>((ref) {
  return ButtonStateIncomming();
});
