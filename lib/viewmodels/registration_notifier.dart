import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationNotifier extends StateNotifier<Map<String, dynamic>> {
  RegistrationNotifier() : super({});
  
  get firestoreProvider => null;

  void updateData(String key, dynamic value) {
    state = {...state, key: value};
  }

  void clear() {
    state = {};
  }
  
}

final registrationProvider = StateNotifierProvider<RegistrationNotifier, Map<String, dynamic>>(
  (ref) => RegistrationNotifier(),
);
