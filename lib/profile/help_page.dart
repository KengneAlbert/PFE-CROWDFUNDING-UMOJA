import 'package:flutter/material.dart';
import 'package:umoja/profile/about_us.dart';
import 'package:umoja/profile/contact_page.dart';
import 'package:umoja/profile/faq_page.dart';
import 'package:umoja/profile/politique_confidentialite.dart';
import 'package:umoja/profile/terms_conditions_page.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

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
        title: const Text('Help'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Social Media Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SocialMediaButton(
                  icon: Icons.camera_alt,
                  label: 'Instagram',
                  onPressed: () {}, // Implement navigation logic
                ),
                SocialMediaButton(
                  icon: Icons.facebook,
                  label: 'Twitter',
                  onPressed: () {}, // Implement navigation logic
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SocialMediaButton(
                  icon: Icons.language,
                  label: 'Website',
                  onPressed: () {}, // Implement navigation logic
                ),
                SocialMediaButton(
                  icon: Icons.play_circle,
                  label: 'YouTube',
                  onPressed: () {}, // Implement navigation logic
                ),
              ],
            ),
          
            const SizedBox(height: 32),

            // Help Section
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  HelpItem(
                    title: 'FAQ',
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF13B156),),
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage()));}, // Implement navigation logic
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  HelpItem(
                    title: 'Contact us',
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF13B156),),
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsPage()));}, // Implement navigation logic
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  HelpItem(
                    title: 'Terms & Conditions',
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF13B156),),
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionsPage()));}, // Implement navigation logic
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  HelpItem(
                    title: 'Privacy Policy',
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF13B156),),
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));}, // Implement navigation logic
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  HelpItem(
                    title: 'About Us',
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF13B156),),
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen()));}, // Implement navigation logic
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function() onPressed;

  const SocialMediaButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF13B156),
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          textStyle: const TextStyle(fontSize: 16, color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: Colors.white),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class HelpItem extends StatelessWidget {
  final String title;
  final Widget trailing;
  final void Function() onTap;

  const HelpItem({
    Key? key,
    required this.title,
    required this.trailing,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }
}