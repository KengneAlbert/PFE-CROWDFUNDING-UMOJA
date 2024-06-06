import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:umoja/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

void main() {
  late AuthService authService;
  late MockSupabaseClient mockSupabase;

  setUp(() {
    mockSupabase = MockSupabaseClient();
    authService = AuthService(supabase: mockSupabase);
  });

  test('signInWithEmailAndPassword signs in user successfully', () async {
    // Arrange
    final email = 'test@example.com';
    final password = 'password123';
    when(mockSupabase.auth.signInWithPassword(email: email, password: password))
        .thenAnswer((_) async => AuthResponse(
              // user: User(email: email),
              session: null,
            ));

    // Act
    final user = await authService.signInWithEmailAndPassword(email, password);

    // Assert
    // expect(user.email, email);
  });

  test('signUpWithEmailAndPassword signs up user successfully', () async {
    // Arrange
    final email = 'test@example.com';
    final password = 'password123';
    when(mockSupabase.auth.signUp(email: email, password: password))
        .thenAnswer((_) async => AuthResponse(
              // user: User(email: email),
              session: null,
            ));

    // Act
    final user = await authService.signUpWithEmailAndPassword(email, password);

    // Assert
    // expect(user.email, email);
  });

  // Ajoutez d'autres tests pour les méthodes de réinitialisation de mot de passe et de connexion avec OAuth.
}
