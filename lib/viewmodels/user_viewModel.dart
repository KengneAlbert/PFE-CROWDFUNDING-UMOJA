import 'package:flutter/material.dart';
import 'package:umoja/models/user_model.dart';
import 'package:umoja/services/auth_service.dart';
import 'package:umoja/services/user_service.dart';


class AuthViewModel extends ChangeNotifier {
  final AuthService authService;

  AuthViewModel({required this.authService});

  UserProfile? _currentUserProfile;
  UserProfile? get currentUserProfile => _currentUserProfile;

  Future<void> signIn(String email, String password) async {
    try {
      final user = await authService.signInWithEmailAndPassword(email, password);
      if (user != null) {
        await loadUserProfile(user.id);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final user = await authService.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        await createUserProfile(user.id, email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadUserProfile(String userId) async {
    try {
      _currentUserProfile = await fetchUserProfile(userId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await authService.signOut();
  }

  Future<void> createUserProfile(String userId, String email) async {
    _currentUserProfile = UserProfile(
      userId: userId,
      email: email,
      name: '',
      phone: '',
      country: '',
      gender: '',
      age: 18,
      location: '',
      profilePicture: '',
      interests: [],
      pinCode: '',
    );
    try {
      await saveUserProfile(_currentUserProfile!);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
