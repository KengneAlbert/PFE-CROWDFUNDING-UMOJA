import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import 'package:umoja/inbox/inbox_chat.dart';

//import 'onboarding_screen/sign_method.dart';
//import 'onboarding_screen/sign_up.dart';
import 'onboarding_screen/splash_screen.dart';
//import 'onboarding_screen/carousel_1.dart';
//import 'onboarding_screen/carousel_2.dart';
//import 'onboarding_screen/carousel_3.dart';

import 'homepage/HomePage.dart';
import 'notification/NotificationPage.dart';
import 'bookmark/BookmarkPage.dart';
import 'search/SearchPage.dart';
import 'UrgentFundraising/UrgentFundraisingPage.dart';
import 'ComingToAnEnd/ComingToAnEndPage.dart';
import 'WatchImpact/WatchImpact.dart';
import 'bookmark/BookmarkPageContaintDetail.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
      //UrgentFundraisingPage(),
      //SplashScreen()
      //WatchImpact(),
      //BookmarkPageContaintDetail(),
      //WatchImpact(),
      //VideoScreen(),
      //ComingToAnEndPage(),
      //NotificationPage(),
      
    );
  }
}

