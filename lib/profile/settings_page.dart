import 'package:flutter/material.dart';
import 'package:umoja/profile/edit_profile.dart';
import 'package:umoja/profile/help_page.dart';
import 'package:umoja/profile/notification_page.dart';
import 'package:umoja/profile/security_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156)),
        ),
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
          ),
          SettingItem(
            icon: Icons.person,
            title: 'Edit Profile',
            trailing: Icon(Icons.arrow_forward_ios,color: Color(0xFF13B156)),
            onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
          ),
          SettingItem(
            icon: Icons.notifications,
            title: 'Notification',
            trailing: Icon(Icons.arrow_forward_ios,color: Color(0xFF13B156)),
            onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
          ),
          SettingItem(
            icon: Icons.lock,
            title: 'Security',
            trailing: Icon(Icons.arrow_forward_ios,color: Color(0xFF13B156)),
            onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => SecurityPage()));},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
          ),
          SettingItem(
            icon: Icons.brightness_4,
            title: 'Dark Mode',
            trailing: Switch(
              activeColor: Color(0xFF13B156),
              value: false, // Use a boolean to control the switch state
              onChanged: (value) {}, // Handle switch change here
            ),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
          ),
          SettingItem(
            icon: Icons.help,
            title: 'Help',
            trailing: Icon(Icons.arrow_forward_ios,color: Color(0xFF13B156)),
            onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
          ),
          SettingItem(
            icon: Icons.person_add,
            title: 'Invite Friends',
            trailing: Icon(Icons.arrow_forward_ios,color: Color(0xFF13B156)),
            // onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => ));},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFFFF1843).withOpacity(0.1),
              child: Icon(Icons.logout, color: Color(0xFFFF1843)),
            ),
            title: Text('Logout'),
            trailing: SizedBox.shrink(),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;
  final void Function()? onTap;

  const SettingItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(0xFF13B156).withOpacity(0.1),
        child: Icon(icon, color: Color(0xFF13B156)),
      ),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }
}