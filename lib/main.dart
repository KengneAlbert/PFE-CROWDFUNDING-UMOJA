import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
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
// import 'bookmark/BookmarkPageContaintDetail.dart';
import 'prayers/PrayersPage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseFirestore db = FirebaseFirestore.instance;

  runApp(Umoja());
}


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




