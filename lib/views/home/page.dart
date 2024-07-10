import 'package:flutter/material.dart';
import 'package:umoja/generalLayouts/ContainerBottom.dart';
import 'package:umoja/views/homepage/HomePage.dart';
import 'package:umoja/views/inbox/homeS.dart';
import 'package:umoja/views/inbox/inbox_page.dart';
import 'package:umoja/views/my_donation/60_Light_my_donation_ist.dart';
import 'package:umoja/views/profile/profile_page.dart';
import 'package:umoja/views/my_fundraising/62_Light_my_fundraising_ongoing.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MyDonationScreen2(),
    MyFundraising62(),
    // InboxPage(),
    HomeChat(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(0.0),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed, // Important for fixed-size items
          backgroundColor: Color(0xFF13B156), // Background color of the bar
          selectedItemColor: Colors.white, // Selected item text color
          unselectedItemColor: Colors.black, 
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              label: 'Home',
              // Background color for selected item
              backgroundColor: const Color(0xFF13B156), 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,),
              label: 'Search',
              // Background color for selected item
              backgroundColor: const Color(0xFF13B156), 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today,),
              label: 'Calendar',
              // Background color for selected item
              backgroundColor: const Color(0xFF13B156), 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat,),
              label: 'Chat',
              // Background color for selected item
              backgroundColor: const Color(0xFF13B156), 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,),
              label: 'Profile',
              // Background color for selected item
              backgroundColor: const Color(0xFF13B156), 
            ),
          ],
        ),
      ),
    );
  }
}
