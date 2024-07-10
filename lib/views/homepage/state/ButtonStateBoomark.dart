import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Définir un modèle pour l'état du bouton
class ButtonStateBoomark {
  final bool isBookmarked;

  ButtonStateBoomark({required this.isBookmarked});
}

// Définir un StateNotifier pour gérer l'état
class ButtonStateNotifier extends StateNotifier<ButtonStateBoomark> {
  ButtonStateNotifier() : super(ButtonStateBoomark(isBookmarked: false));

  void toggleBookmark() {
    state = ButtonStateBoomark(isBookmarked: !state.isBookmarked);
  }
}

// Définir un provider pour ButtonStateNotifier
final buttonStateBoomarkProvider = StateNotifierProvider<ButtonStateNotifier, ButtonStateBoomark>((ref) {
  return ButtonStateNotifier();
});
