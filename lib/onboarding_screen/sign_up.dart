import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';

import '../account_setup/select_country_page.dart';
import '../account_setup/select_interest.dart';
import 'sign_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Variables pour gérer l'état du formulaire
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _emailInvalid = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo UMOJA
                Image.asset('assets/images/logo_mini.png'), 
                const SizedBox(height: 20),
                // Titre "Sign up for free"
                const Text(
                  'Sign up for free',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                // Champ Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email *',
                    errorText: _emailInvalid ? 'Invalid email' : null,
                    // Bordure lorsque les conditions sont respectées
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF13B156)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      setState(() {
                        _emailInvalid = true;
                      });
                      return 'Please enter a valid email';
                    }
                    setState(() {
                      _emailInvalid = false;
                    });
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Champ Mot de passe
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password *',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () {}, // TODO: Implementer la fonctionnalité pour afficher/masquer le mot de passe
                    ),
                    // Bordure lorsque les conditions sont respectées
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF13B156)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Checkbox "Remember me"
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                      activeColor: Color(0xFF13B156),
                    ),
                    const Text('Remember me'),
                  ],
                ),
                const SizedBox(height: 20),
                // Bouton "Sign up"
                CustomBouton(
                  label: "Sign up", 
                  onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context) => SelectInterestPage()));
                  },
                ),

                const SizedBox(height: 20),
                // Texte "or continue with"
                const Text('or continue with'),
                const SizedBox(height: 20),
                // Boutons Facebook, Google, Apple
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.facebook),
                      onPressed: () {}, // TODO: Implementer la connexion avec Facebook
                    ),
                    IconButton(
                      icon: const Icon(Icons.facebook), // Remplacez par le chemin de votre logo Google
                      onPressed: () {}, // TODO: Implementer la connexion avec Google
                    ),
                    IconButton(
                      icon: const Icon(Icons.apple),
                      onPressed: () {}, // TODO: Implementer la connexion avec Apple
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Lien "Already have an account?"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SignInPage()));
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Color(0xFF13B156), 
                        ),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}