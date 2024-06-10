import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signIn(String email, String password) async {
   try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        throw Exception('Wrong password provided for that user.');
      }else{
        throw Exception('Failed to sign up: ${e.message}');
      }
    }catch (e){
      print(e);
     throw Exception('An unknown error occurred.');
    }
  }

  Future<UserCredential> signUp(String email, String password) async {
    try {
        final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          throw Exception('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          throw Exception('The password provided is too weak.');
        }else {
          throw Exception('Failed to sign up: ${e.message}');
        }
      } catch (e) {
        print(e);
        throw Exception('An unknown error occurred.');
      }
  }

  Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await _firebaseAuth.signInWithCredential(credential);
}

Future<UserCredential> signInWithFacebook() async {
  // Déclencher le flux de connexion
  final LoginResult loginResult = await FacebookAuth.instance.login();

  if (loginResult.status == LoginStatus.success) {
    final AccessToken? accessToken = loginResult.accessToken;

    if (accessToken != null) {
      // Créer des informations d'identification à partir du jeton d'accès
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(accessToken.tokenString);

      // Une fois connecté, renvoyer les informations d'identification de l'utilisateur
      return await _firebaseAuth.signInWithCredential(facebookAuthCredential);
    } else {
      throw Exception('AccessToken is null');
    }
  } else {
    throw Exception('Failed to sign in with Facebook: ${loginResult.message}');
  }
}


Future<UserCredential> signInWithApple() async {
  final appleProvider = AppleAuthProvider();

  UserCredential userCredential = await _firebaseAuth.signInWithPopup(appleProvider);
  // Keep the authorization code returned from Apple platforms
  String? authCode = userCredential.additionalUserInfo?.authorizationCode;
  // Revoke Apple auth token
  await _firebaseAuth.revokeTokenWithAuthorizationCode(authCode!);
  return userCredential;
}

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
