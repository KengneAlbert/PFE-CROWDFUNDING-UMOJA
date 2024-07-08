// import 'package:flutter/material.dart';
// import 'package:umoja/views/homepage/HomePage.dart';
// import 'package:umoja/views/inbox/inbox_page.dart';
// import 'package:umoja/views/my_donation/60_Light_my_donation_ist.dart';
// import 'package:umoja/views/my_fundraising/62_Light_my_fundraising_ongoing.dart';
// import 'package:umoja/views/profile/profile_page.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ContainerBottom(),
//       routes: {
//         '/home': (context) => Home(),
//         '/calendar': (context) => CalendarScreen(),
//         '/grid': (context) => GridScreen(),
//         '/messages': (context) => MessagesScreen(),
//         '/profilepage': (context) => ProfileScreen(),
//       },
//     );
//   }
// }

// class ContainerBottom extends StatefulWidget {
//   @override
//   _ContainerBottomState createState() => _ContainerBottomState();
// }

// class _ContainerBottomState extends State<ContainerBottom> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     HomePage(),
//     CalendarScreen(),
//     GridScreen(),
//     MessagesScreen(),
//     ProfileScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _pages,
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//           ),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//           ),
//           child: BottomNavigationBar(
//             currentIndex: _selectedIndex,
//             onTap: _onItemTapped,
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: _selectedIndex == 0 ? Colors.green : Color(0x13B1561A),
//                   ),
//                   child: Icon(
//                     Icons.home,
//                     color: _selectedIndex == 0 ? Colors.white : Colors.green,
//                   ),
//                 ),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: _selectedIndex == 1 ? Colors.green : Color(0x13B1561A),
//                   ),
//                   child: Icon(
//                     Icons.calendar_today,
//                     color: _selectedIndex == 1 ? Colors.white : Colors.green,
//                   ),
//                 ),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: _selectedIndex == 2 ? Colors.green : Color(0x13B1561A),
//                   ),
//                   child: Icon(
//                     Icons.grid_view,
//                     color: _selectedIndex == 2 ? Colors.white : Colors.green,
//                   ),
//                 ),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: _selectedIndex == 3 ? Colors.green : Color(0x13B1561A),
//                   ),
//                   child: Icon(
//                     Icons.message,
//                     color: _selectedIndex == 3 ? Colors.white : Colors.green,
//                   ),
//                 ),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: _selectedIndex == 4 ? Colors.green : Color(0x13B1561A),
//                   ),
//                   child: Icon(
//                     Icons.person,
//                     color: _selectedIndex == 4 ? Colors.white : Colors.green,
//                   ),
//                 ),
//                 label: '',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Placeholder widgets for the different screens
// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Home Screen'));
//   }
// }

// class CalendarScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Calendar Screen'));
//   }
// }

// class GridScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Grid Screen'));
//   }
// }

// class MessagesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Messages Screen'));
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Profile Screen'));
//   }
// }
