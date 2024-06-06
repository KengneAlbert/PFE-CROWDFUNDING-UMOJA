import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:umoja/services/auth_service.dart';
import 'package:umoja/viewmodels/user_viewModel.dart';
import 'package:umoja/views/account_setup/profile_page.dart';
import 'package:umoja/views/profile/profile_page.dart';
import '../account_setup/select_country_page.dart';
import 'package:provider/provider.dart';
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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    return null;
  }

   String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    
    final authService = Provider.of<AuthService>(context, listen: false);
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
                  validator: _validateEmail,
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
                  validator: _validatePassword,
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
                  onPressed: () async {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
                      
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                      
                      try {
                          await authViewModel.signUp(email, password);
                          Navigator.pop(context); // Remove the loading indicator
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => FillProfilePage()),
                          );
                        } catch (e) {
                          Navigator.pop(context); // Remove the loading indicator
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Erreur lors de l\'inscription: $e')),
                          );
                        }
                      

                      // if(_formKey.currentState!.validate()){
                      //   await Provider.of<AuthViewModel>(context, listen: false)
                      //     .signUp(_emailController.text, _passwordController.text);
                      //    final User? result = await authService.signUpWithEmailAndPassword(
                      //         _emailController.text,
                      //         _passwordController.text,
                      //     );
                      //     if(result != null){
                      //       Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => SelectCountryPage(),
                      //         ),
                      //      );
                      //     }else{
                      //       // Afficher le message d'erreur à l'utilisateur
                      //       // print(result);
                      //       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result!)));
                      //     }
                      // }
                    
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
                      onPressed: () async {
                        final result = await authService.signInWithOAuth(OAuthProvider.facebook);
                        // if (result) {
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => SelectCountryPage(),
                        //     ),
                        //   );
                        // }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.facebook), // Remplacez par le chemin de votre logo Google
                      onPressed: () async {
                        final result = await authService.signInWithOAuth(OAuthProvider.google);
                        // if (result) {
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => SelectCountryPage(),
                        //     ),
                        //   );
                        // }
                      }, 
                    ),
                    IconButton(
                      icon: const Icon(Icons.apple),
                      onPressed: () async {
                        // bool result = await authService.signInWithApple();
                        // if (result) {
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => SelectCountryPage(),
                        //     ),
                        //   );
                        // }
                      }
                    )
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