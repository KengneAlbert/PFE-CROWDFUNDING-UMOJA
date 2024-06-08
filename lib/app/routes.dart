import 'package:umoja/views/account_setup/profile.dart';
import 'package:umoja/views/home/page.dart';
import 'package:umoja/views/onboarding_screen/sign_up.dart';

class AppRoutes{
  static const String FirsRoute = '/signUp';
  static final routes = {
    FirsRoute: (context) => SignUpPage(),
    '/profile': (context) => FillProfilePage(),
    '/home': (context) => HomePage(),
    
    };
}