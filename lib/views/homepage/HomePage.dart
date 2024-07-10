import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'ContainerBody.dart';
import '../generalLayouts/ContainerBottom.dart';
import '../search/SearchPage.dart';
import '../notification/NotificationPage.dart';
import '../bookmark/BookmarkPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        leading: SvgPicture.asset(
          'assets/icons/svg/Group.svg',
          width: 36,
          height: 36,
          ),
        title: Text(
          'UMOJA',
          style: TextStyle(
            fontSize: 26,
            height: 39,
            color: Color(0xFF09101D),
            fontWeight: FontWeight.w600,
          ),
        ), 
        actions:[

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>  SearchPage()
                )
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF13B156).withOpacity(0.1), // Couleur de fond
                borderRadius: BorderRadius.circular(12), // Bordure arrondie
              ),
              child: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset('assets/icons/svg/search.svg'), // Image SVG
              ),
            ),
          ),

          SizedBox(width: 15),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>   NotificationPage()
                )
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF13B156).withOpacity(0.1), // Couleur de fond
                borderRadius: BorderRadius.circular(12), // Bordure arrondie
              ),
              child: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset('assets/icons/svg/notifications.svg'), // Image SVG
              ),
            ),
          ),

          SizedBox(width: 15),

           GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>   BookmarkPage(),
                )
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF13B156).withOpacity(0.1), // Couleur de fond
                borderRadius: BorderRadius.circular(12), // Bordure arrondie
              ),
              child: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset('assets/icons/svg/bookmark.svg'), // Image SVG
              ),
            ),
          )

        ], 
      ),

      body: ContainerBody(),

      // bottomNavigationBar: ContainerBottom(),

    );
  }
}
