import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/user_model.dart';
import 'package:umoja/services/auth_service.dart';

class AuthViewModel extends StateNotifier<UserModel?> {
  final AuthService _authService;

   AuthViewModel(this._authService) : super(null) {
    _authService.currentUser != null ? state = UserModel.fromFirebaseUser(_authService.currentUser!) : null;
  }

  bool isLoading = false;
  bool get isAuthenticated => state != null;

  Future<void> signIn(String email, String password) async {
    try {
      isLoading = true;
      final UserCredential credential = await _authService.signIn(email, password);
      state = UserModel.fromFirebaseUser(credential.user!);
      isLoading = false;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final UserCredential credential = await _authService.signUp(email, password);
      state = UserModel.fromFirebaseUser(credential.user!);
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

    Future<void> signInWithGoogle() async {
    try {
      final UserCredential credential = await _authService.signInWithGoogle();
      state = UserModel.fromFirebaseUser(credential.user!);
    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final UserCredential credential = await _authService.signInWithFacebook();
      state = UserModel.fromFirebaseUser(credential.user!);
    } catch (e) {
      throw Exception('Failed to sign in with Facebook: $e');
    }
  }

  Future<void> signInWithApple() async {
    try {
      final UserCredential credential = await _authService.signInWithApple();
      state = UserModel.fromFirebaseUser(credential.user!);
    } catch (e) {
      throw Exception('Failed to sign in with Facebook: $e');
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = null;
  }
}

final authServiceProvider = Provider((ref) => AuthService());
final authViewModelProvider = StateNotifierProvider<AuthViewModel, UserModel?>(
  (ref) => AuthViewModel(ref.read(authServiceProvider)),
);
