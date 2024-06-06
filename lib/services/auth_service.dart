import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends  ChangeNotifier {
  final SupabaseClient supabase;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  AuthService({required this.supabase});
  // Méthodes pour gérer l'authentification
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      _isLoggedIn = true;
      notifyListeners();
      return response.user;
    } on AuthException catch  (error) {
       // Gérer les erreurs d'authentification
      // String errorMessage = 'Erreur lors de la connexion.';
        // switch (error.statusCode) {
        //   case 'invalid_email':
        //     errorMessage = 'Adresse email invalide.';
             
        //     break;
        //   case 'wrong_password':
        //     errorMessage = 'Mot de passe incorrect.';
        //     break;
        //   default:
        //     errorMessage = 'Erreur lors de la connexion.';
        // }
        throw Exception('Erreur lors de la connexion : ${error.message}');   
    }
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      notifyListeners();
      return response.user;
    }on AuthException catch (error) {
      throw Exception('Erreur lors de la connexion : ${error.message}');   
      // Gérer les erreurs d'authentification
    //  String errorMessage = 'Erreur d\'inscription.';
    //     switch (error.statusCode) {
    //       case 'email already exists':
    //         errorMessage = 'Email déjà utilisé.';
             
    //         break;
    //       case 'password too weak':
    //         errorMessage = 'Mot de passe trop faible.';
    //         break;
    //       default:
    //         errorMessage = 'Erreur d\'inscription.';
    //     }
    //     print(error.statusCode);
    //     return errorMessage;
    }
  }

  Future<void> resetPasswordForEmail(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
      notifyListeners();
    } on AuthException catch (error) {
      throw Exception("Erreur lors de l'envoi de l'email de réinitialisation : ${error.message}");
    }
  }

 Future<void> signInWithOAuth(OAuthProvider provider) async {
    try {
      await supabase.auth.signInWithOAuth(
        provider, 
        redirectTo: 'https://yhpmujqzgoqfiultqleq.supabase.co/auth/v1/callback'
      );
      notifyListeners();
    } on AuthException catch (error) {
      throw Exception('Erreur lors de la connexion avec ${provider.name} : ${error.message}');
    }
  }
  
  

// Future<void> signUpWithGoogle() async {
//   final googleSignIn = GoogleSignIn();
//   final googleUser = await googleSignIn.signIn();

//   if (googleUser != null) {
//     final googleAuth = await googleUser.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     // Enregistrement avec Google dans Supabase
//     final response = await supabase.auth.signUpWithCredential(credential);

//     if (response.error != null) {
//       // Gérer les erreurs
//       print(response.error.message); 
//     } else {
//       // Utilisateur enregistré avec succès
//       final user = response.user;
//       // Stocker les informations de l'utilisateur dans Supabase
//       await supabase
//           .from('users')
//           .insert({'email': user.email, 'name': user.displayName});

//       // Rediriger vers l'écran d'accueil ou autre
//     }
//   } else {
//     // Gérer le cas où la connexion a échoué
//   }
// }



  Future<void> signOut() async {
    await supabase.auth.signOut();
    _isLoggedIn = false;
    notifyListeners();
  }

  // Obtenir l'utilisateur actuel
  User? get currentUser => supabase.auth.currentUser;
}