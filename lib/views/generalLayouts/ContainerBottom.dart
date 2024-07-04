import 'package:flutter/material.dart';

class ContainerBottom extends StatefulWidget {
  @override
  _ContainerBottomState createState() => _ContainerBottomState();
}

class _ContainerBottomState extends State<ContainerBottom> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Naviguez vers les différentes pages en fonction de l'index sélectionné
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/calendar');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/grid');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/messages');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _selectedIndex == 0 ? Colors.green : Color(0x13B1561A),
                ),
                child: Icon(
                  Icons.home,
                  color:  _selectedIndex == 0 ? Colors.white : Colors.green,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _selectedIndex == 1 ? Colors.green : Color(0x13B1561A),
                ),
                child: Icon(
                  Icons.calendar_today,
                  color:  _selectedIndex == 1 ? Colors.white : Colors.green,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _selectedIndex == 2 ? Colors.green : Color(0x13B1561A),
                ),
                child: Icon(
                  Icons.grid_view,
                  color:  _selectedIndex == 2 ? Colors.white : Colors.green,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _selectedIndex == 3 ? Colors.green : Color(0x13B1561A),
                ),
                child: Icon(
                  Icons.message,
                  color:  _selectedIndex == 3 ? Colors.white : Colors.green,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _selectedIndex == 4 ? Colors.green : Color(0x13B1561A),
                ),
                child: Icon(
                  Icons.person,
                  color:  _selectedIndex == 4 ? Colors.white : Colors.green,
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
