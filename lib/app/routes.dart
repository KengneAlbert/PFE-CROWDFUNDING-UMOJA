import 'package:umoja/views/account_setup/profile.dart';
import 'package:umoja/views/home/page.dart';
import 'package:umoja/views/my_fundraising/70_Light_my_fundraising_create_new_fundraising_filled_form_full_page.dart';
import 'package:umoja/views/my_fundraising/ai_check.dart';
import 'package:umoja/views/onboarding_screen/sign_in.dart';
import 'package:umoja/views/onboarding_screen/sign_up.dart';
import 'package:umoja/views/profile/settings_page.dart';

class AppRoutes{
  static const String FirsRoute = '/signUp';
  static final routes = {
  //  FirsRoute: (context) => PublishProjectPage(),
    FirsRoute: (context) => SignUpPage(),
    // FirsRoute: (context) => CreateNewFundraisingPage(),
    '/profile': (context) => FillProfilePage(),
    '/home': (context) => HomePage(),
    
    };
}