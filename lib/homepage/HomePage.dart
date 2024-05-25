import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umoja/notification/NotificationPage.dart';
import 'ContainerBody.dart';
import '../generalLayouts/ContainerBottom.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
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
          ElevatedButton(
            onPressed: () {},
            child: SvgPicture.asset(
              'assets/icons/svg/search.svg',
              width: 24,
              height: 24,
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(10.0),
            ),
          ),

          SizedBox(width: 4),

          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
            },
            child: SvgPicture.asset(
              'assets/icons/svg/notifications.svg',
              width: 24,
              height: 24,
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(10.0),
            ),
          ),

          SizedBox(width: 4),

          ElevatedButton(
            onPressed: () {},
            child: SvgPicture.asset(
              'assets/icons/svg/bookmark.svg',
              width: 24,
              height: 24,
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(10.0),
            ),
          ),
        ], 
      ),

      body: ContainerBody(),

      bottomNavigationBar: ContainerBottom(),

    );
  }
}
