import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:umoja/services/auth_service.dart';
import 'package:umoja/viewmodels/auth_viewModel.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  group('AuthViewModel Tests', () {
    late AuthViewModel authViewModel;
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
      authViewModel = AuthViewModel(authService: mockAuthService);
    });

    test('initial state is correct', () {
      expect(authViewModel.isLoading, false);
      expect(authViewModel.isAuthenticated, false);
    });

    test('signIn updates state correctly on success', () async {
      // when(mockAuthService.signIn(any, any))
      //     .thenAnswer((_) async => true);

      await authViewModel.signIn('email', 'password');

      expect(authViewModel.isAuthenticated, true);
      verify(mockAuthService.signIn('email', 'password')).called(1);
    });

    test('signIn updates state correctly on failure', () async {
      // when(mockAuthService.signIn(any, any))
      //     .thenAnswer((_) async => false);

      await authViewModel.signIn('email', 'password');

      expect(authViewModel.isAuthenticated, false);
      verify(mockAuthService.signIn('email', 'password')).called(1);
    });
  });
}
