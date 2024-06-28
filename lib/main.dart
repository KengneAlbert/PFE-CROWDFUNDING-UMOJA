import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/constant/constant.dart';
import 'package:umoja/models/projet_model.dart';
import 'package:umoja/models/user_model.dart';
import 'package:umoja/services/database_service.dart';
import 'package:umoja/viewmodels/auth_viewModel.dart';
import 'package:umoja/viewmodels/projet_viewModel.dart';
import 'package:umoja/viewmodels/user_viewModel.dart';
import 'package:umoja/views/onboarding_screen/sign_up.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase_options.dart';
import 'package:umoja/app/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
   Stripe.publishableKey = stripePublishableKey;

  
  await Stripe.instance.applySettings();
  runApp(
    ProviderScope(
      child: Umoja(),
    ),
  );
}

final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
final firebaseStorageProvider = Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final databaseServiceProvider = Provider<DatabaseService>((ref) => DatabaseService());

final projetViewModelProvider = StateNotifierProvider<ProjetViewModel, List<ProjetModel?>>((ref) {
  return ProjetViewModel(projetService: ref.read(databaseServiceProvider));
});
final userServiceProvider = Provider((ref) => UserService());
final authViewModelProvider = StateNotifierProvider<AuthViewModel, UserModel?>((ref) => AuthViewModel());


class Umoja extends StatelessWidget {
  const Umoja({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      // home: SignUpPage(),
      initialRoute: AppRoutes.FirsRoute,
      routes: AppRoutes.routes,
    );
  }
}




