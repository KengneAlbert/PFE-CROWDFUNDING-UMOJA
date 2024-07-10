import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonSeeAllVoteState extends StateNotifier<String> {
  ButtonSeeAllVoteState() : super('All');  // Initialiser avec 'All'

  void selectButton(String buttonText) {
    state = buttonText;
  }
}

final buttonSeeAllVoteStateProvider = StateNotifierProvider<ButtonSeeAllVoteState, String>((ref) {
  return ButtonSeeAllVoteState();
});
