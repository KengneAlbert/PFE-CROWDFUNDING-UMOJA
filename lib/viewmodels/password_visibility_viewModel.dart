import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordVisibilityState {
  final bool obscureText;

  PasswordVisibilityState({required this.obscureText});
}

class PasswordVisibilityViewModel extends StateNotifier<PasswordVisibilityState> {
  PasswordVisibilityViewModel() : super(PasswordVisibilityState(obscureText: true));

  void togglePasswordVisibility() {
    state = PasswordVisibilityState(obscureText: !state.obscureText);
  }
}

final passwordVisibilityProvider = StateNotifierProvider<PasswordVisibilityViewModel, PasswordVisibilityState>(
  (ref) => PasswordVisibilityViewModel(),
);
