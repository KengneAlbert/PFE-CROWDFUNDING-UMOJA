import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/user_model.dart';
import 'package:umoja/services/auth_service.dart';
import 'package:umoja/services/database_service.dart';

class AuthViewModel extends StateNotifier<UserModel?> {
  static final AuthService _authService = AuthService();
  static final DatabaseService _databaseService = DatabaseService();

   AuthViewModel() : super(null) {
   _authService.userStream.listen((user) =>
    user !=null ? _databaseService.fetchOne("users/${user.uid}").then((value) => state = value !=null? UserModel.fromMap(value) : null ): state = null);
  }

  bool isLoading = false;
  bool get isAuthenticated => state != null;

  Future<void> signIn(String email, String password) async {
    try {
      isLoading = true;
      final UserCredential credential = await _authService.signIn(email, password);
      // state = UserModel(uid: _authService.currentUser!.uid, email:_authService.currentUser!.email!);
      isLoading = false;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      isLoading = true;
      final UserCredential credential = await _authService.signUp(email, password);
      await _authService.signIn(email, password);
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<void> setUserProfile(String name, String phone, String country, String gender, int age, String location, String profile_picture, List<String> interests, int pin_code)async{
    final  userMap = {'name': name, 'phone':phone, 'country': country, 'gender': gender, 'age': age, 'location': location, 'profile_picture': profile_picture, 'interests': interests, 'pin_code': pin_code};
    _databaseService.update("users/${state!.uid}", userMap);
  }

  Future<UserModel?> fetchOneUser(String uid)async{
    final userMap = await _databaseService.fetchOne("users/$uid");
    return userMap != null ? UserModel.fromMap(userMap) : null ;
  }

  Future<List<UserModel?>> fetchAllUser() async{
    final userMapList = await _databaseService.fetchAll("users");
    final UserModelList = userMapList.map((map) => map != null ? UserModel.fromMap(map) : null).toList();
    return UserModelList;
  }

  Future<void> deleteUser(String uid) async {
    await _databaseService.delete("users/$uid");
  }

    Future<void> signInWithGoogle() async {
    try {
      final UserCredential credential = await _authService.signInWithGoogle();
    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final UserCredential credential = await _authService.signInWithFacebook();
    } catch (e) {
      throw Exception('Failed to sign in with Facebook: $e');
    }
  }

  Future<void> signInWithApple() async {
    try {
      final UserCredential credential = await _authService.signInWithApple();
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
  (ref) => AuthViewModel(),
);
