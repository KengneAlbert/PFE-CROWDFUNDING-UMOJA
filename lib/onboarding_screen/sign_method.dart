import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';

import 'sign_in.dart';
import 'sign_up.dart';

class SignMethod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image de bienvenue avec les chats
              Image.asset('assets/images/Welcome.png'),
             
              SizedBox(height: 10),
              Text(
                "Let's you in",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              // Boutons de connexion avec les réseaux sociaux
              _SocialLoginButton(
                iconData: FontAwesomeIcons.facebookF,
                text: 'Facebook',
                onPressed: () {
                  // Gérer la connexion avec Facebook
                },
              ),
              SizedBox(height: 15),
              _SocialLoginButton(
                iconData: FontAwesomeIcons.google,
                text: 'Google',
                onPressed: () {
                  // Gérer la connexion avec Google
                },
              ),
              SizedBox(height: 15),
              _SocialLoginButton(
                iconData: FontAwesomeIcons.apple,
                text: 'Apple',
                onPressed: () {
                  // Gérer la connexion avec Apple
                },
              ),
              SizedBox(height: 20),
              Text(
                'or',
                style: TextStyle(
                          color: Colors.black,
                          fontSize: 20, 
                        ),
                ),
              SizedBox(height: 20),
              // Bouton de connexion avec mot de passe
              CustomBouton(
                    label: "Sign in with password", 
                    onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder:(context) => SignInPage()));
                    },
                  ),

              SizedBox(height: 20),
              // Lien d'inscription
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    child: Text(
                      'Sign up',
                       style: TextStyle(
                          color: Color(0xFF13B156), 
                        ),
                      ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context) => SignUpPage()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget personnalisé pour les boutons de connexion avec les réseaux sociaux
class _SocialLoginButton extends StatelessWidget {
  final IconData iconData; 
  final String text;
  final VoidCallback onPressed;

  _SocialLoginButton({
    required this.iconData,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 
                              MediaQuery.of(context).size.height * 0.07), // 80% width, 6% height
               shape: RoundedRectangleBorder( // Ajouter BorderRadius
                  borderRadius:  BorderRadius.all(Radius.circular(8)),
        ),
                        ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(iconData),
          SizedBox(width: 10),
          Text(text, style: TextStyle(color: Colors.black),),
        ],
      ),
      onPressed: onPressed,
    );
  }
}