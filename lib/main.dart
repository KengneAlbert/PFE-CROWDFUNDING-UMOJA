import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:umoja/constant/constant.dart';
import 'package:umoja/services/auth_service.dart';
import 'package:umoja/viewmodels/user_viewModel.dart';
import 'package:umoja/views/account_setup/profile_page.dart';
import 'package:umoja/views/home/page.dart';
import 'package:umoja/views/onboarding_screen/sign_up.dart';
import 'package:umoja/views/onboarding_screen/splash_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  final supabase = Supabase.instance.client;
  final authService = AuthService(supabase: supabase);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (_) => AuthService(supabase: supabase),
        ),
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => AuthViewModel(authService: authService),
        ),
      ],
      child: MyApp(),
    ), 
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => SignUpPage(),
        '/profile': (context) => FillProfilePage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}




