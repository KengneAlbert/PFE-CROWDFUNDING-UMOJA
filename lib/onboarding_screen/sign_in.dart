import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umoja/account_setup/select_country_page.dart';
import 'package:umoja/home/page.dart';
import 'package:umoja/homepage/HomePage.dart';
import 'package:umoja/onboarding_screen/Auth/Auth.dart';

import 'forgot_password.dart';
import 'sign_up.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Variables pour gérer l'état du formulaire
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _emailInvalid = false;
  bool _obscureText = true;
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
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
                  'Sign in to your account',
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
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Password *',
                    suffixIcon: IconButton(
                       icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF13B156), // Green background
                          minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 
                                          MediaQuery.of(context).size.height * 0.06), // 80% width, 15% height
                        ),
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      final bool result = await authService.signInWithEmailAndPassword(
                              _emailController.text,
                              _passwordController.text,
                          );
                        if(result){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        }
                     
                    }
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white, 
                      ),
                    ),
                ),
                const SizedBox(height: 20),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => ForgotPasswordPage()));
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Color(0xFF13B156), 
                        ),
                        ),
                    ),
                  ],
                ),
                // Texte "or continue with"
                const Text('or continue with'),
                const SizedBox(height: 20),
                // Boutons Facebook, Google, Apple
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.facebook),
                      onPressed: () async {
                        bool result = await authService.signInWithFacebook();
                        if (result) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.facebook), // Remplacez par le chemin de votre logo Google
                      onPressed: () async {
                        bool result = await authService.signInWithGoogle();
                        if (result) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      }, // TODO: Implementer la connexion avec Google
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
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SignUpPage()));
                      },
                      child: const Text(
                        'Sign Up',
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

