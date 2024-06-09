import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/user_model.dart';
import 'package:umoja/services/auth_service.dart';

class AuthViewModel extends StateNotifier<UserModel?> {
  final AuthService authService;
  AuthViewModel({required this.authService}) : super(null);

  bool isLoading = false;
  bool get isAuthenticated => state != null;

  Future<void> signIn(String email, String password) async {
    isLoading = true;
    final success = await authService.signIn(email, password);
    if (success) {
      state = UserModel(
          uid: authService.currentUser!.uid, email: authService.currentUser!.email!);
    }
    isLoading = false;
  }

  Future<void> signOut() async {
    await authService.signOut();
    state = null;
  }
}

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, UserModel?>((ref) {
  return AuthViewModel(authService: AuthService());
});
