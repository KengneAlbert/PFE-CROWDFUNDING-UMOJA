import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends  ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Méthodes pour gérer l'authentification
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return true;
    } catch (error) {
      // Gérer les erreurs d'authentification
      print(error);
      return false;
    }
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      notifyListeners();
      return true;
    } catch (error) {
      // Gérer les erreurs d'authentification
      print(error);
      return false;
    }
  }

  Future<bool> resetPasswordForEmail(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      print("Email de réinitialisation de mot de passe envoyé.");
      notifyListeners();
      return true;
    } catch (error) {
      print("Erreur lors de l'envoi de l'email de réinitialisation : $error");
      return false;
    }
  }

  

  Future<bool> signInWithGoogle() async {
    try {
      final response = await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'https://yhpmujqzgoqfiultqleq.supabase.co/auth/v1/callback',
      );
      print('Google sign in: $response');
      return true;
    } catch (error) {
      print('Google sign in error: $error');
      return false;
    }
  }

  Future<bool> signInWithFacebook() async {
    try {
      final response = await _supabase.auth.signInWithOAuth(
        OAuthProvider.facebook,
        redirectTo: 'https://yhpmujqzgoqfiultqleq.supabase.co/auth/v1/callback',
      );
      return true;
    } catch (error) {
      print('Erreur lors de la connexion avec Facebook: $error');
      return false;
    }
  }

  Future<bool> signInWithApple() async {
    try {
      final response = await _supabase.auth.signInWithOAuth(
        OAuthProvider.apple,
        redirectTo: 'https://yhpmujqzgoqfiultqleq.supabase.co/auth/v1/callback',
      );
      return true;
    } catch (error) {
      print('Erreur lors de la connexion avec Facebook: $error');
      return false;
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    notifyListeners();
  }

  // Obtenir l'utilisateur actuel
  User? get currentUser => _supabase.auth.currentUser;
}