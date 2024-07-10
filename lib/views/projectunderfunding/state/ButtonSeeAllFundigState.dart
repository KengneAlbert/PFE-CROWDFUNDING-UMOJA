import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonSeeAllFundigState extends StateNotifier<String> {
  ButtonSeeAllFundigState() : super('All');  // Initialiser avec 'All'

  void selectButton(String buttonText) {
    state = buttonText;
  }
}

final buttonSeeAllFundigStateProvider = StateNotifierProvider<ButtonSeeAllFundigState, String>((ref) {
  return ButtonSeeAllFundigState();
});
