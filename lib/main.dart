import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:umoja/app/routes.dart';
import 'package:umoja/constant/constant.dart';
import 'package:umoja/models/projet_model.dart';
import 'package:umoja/models/user_model.dart';
import 'package:umoja/services/auth_service.dart';
import 'package:umoja/services/projet_service.dart';
import 'package:umoja/services/user_service.dart';
import 'package:umoja/viewmodels/auth_viewModel.dart';
import 'package:umoja/services/initializeData.dart';
import 'package:umoja/viewmodels/projet_viewModel.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  final supabase = Supabase.instance.client;

  Hive.registerAdapter(UserProfileAdapter()); 
  await Hive.openBox<UserProfile>('users_umoja');

  // Enregistrer l'adaptateur Projet
  Hive.registerAdapter(ProjetAdapter());
  await Hive.openBox<Projet>('projets');

  final authService = AuthService(supabase: supabase);
  final userService = UserService(); // Initialize UserService
  // final dataInitializer = DataInitializer(supabase: supabase);
  // await dataInitializer.initializeData();
  runApp(
    MultiProvider(
      providers: [
                ChangeNotifierProvider<AuthService>(
                      create: (_) => AuthService(supabase: supabase),
                    ),
                ChangeNotifierProvider<AuthViewModel>(
                      create: (_) => AuthViewModel(authService: authService, userService: userService),
                    ),
                ChangeNotifierProvider<UserService>(create: (_) => UserService()),
                ChangeNotifierProvider(create: (_) => ProjetService()),
                ChangeNotifierProvider(create: (context) => ProjetViewModel(projetService: context.read<ProjetService>())),
              ],
      child: Umoja(),
    ), 
  );
}


class Umoja extends StatelessWidget {
  const Umoja({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SignUpPage(),
      initialRoute: AppRoutes.FirsRoute,
      routes: AppRoutes.routes,
    );
  }
}




