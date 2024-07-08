import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';
import 'package:umoja/viewmodels/auth_viewModel.dart';
import 'package:umoja/viewmodels/password_visibility_viewModel.dart';
import 'package:umoja/views/forgot_reset_password/forgot_password.dart';
import 'package:umoja/views/onboarding_screen/sign_up.dart';


class SignInPage extends ConsumerStatefulWidget {
  
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _emailInvalid = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final authViewModel = ref.watch(authViewModelProvider.notifier);
    final isLoading = authViewModel.isLoading;
    final passwordVisibility = ref.watch(passwordVisibilityProvider);
    final passwordVisibilityNotifier = ref.watch(passwordVisibilityProvider.notifier);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
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
                  controller: emailController,
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
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password *',
                    suffixIcon: IconButton(
                       icon: Icon(
                          passwordVisibility.obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: passwordVisibilityNotifier.togglePasswordVisibility,
                    ),
                    // Bordure lorsque les conditions sont respectées
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF13B156)),
                    ),
                  ),
                  obscureText: passwordVisibility.obscureText,
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
                isLoading
                ? CircularProgressIndicator():
                CustomBouton(
                  label: 'Sign In',
                  onPressed: () async{
                    final email = emailController.text;
                    final password = passwordController.text;
                      // showDialog(
                      //   context: context,
                      //   barrierDismissible: false,
                      //   builder: (BuildContext context) {
                      //     return Center(
                      //       child: CircularProgressIndicator(),
                      //     );
                      //   },
                      // );
                      try {
                          if (formKey.currentState!.validate()) {
                              await authViewModel.signIn(email, password);
                              // Navigator.pop(context); // Remove the loading indicator
                              Navigator.restorablePushReplacementNamed( context,'/home',);
                            }
                        } catch (e) {
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Erreur lors de la cconnexion: $e')),
                          );
                        }
                      
                  },
                ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //           backgroundColor: Color(0xFF13B156), // Green background
                //           minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 
                //                           MediaQuery.of(context).size.height * 0.06), // 80% width, 15% height
                //         ),
                //   onPressed: () async{
                //       ;
                      
                      
                      
                    // if (_formKey.currentState!.validate()) {
                    //   final User? result = await authViewModel.signInWithEmailAndPassword(
                    //           _emailController.text,
                    //           _passwordController.text,
                    //       );
                    //     if(result != null){
                    //       Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => HomePage(),
                    //         ),
                    //       );
                    //     }else{
                    //       // Afficher le message d'erreur à l'utilisateur
                    //     //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result!)));
                    //     }
                     
                    // }
                //   },
                //   child: const Text(
                //     'Sign In',
                //     style: TextStyle(
                //         fontSize: 14,
                //         color: Colors.white, 
                //       ),
                //     ),
                // ),
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
                        // final result = await authViewModel.signInWithOAuth(OAuthProvider.facebook);
                        // if (result) {
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => HomePage()),
                        //   );
                        // }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.facebook), // Remplacez par le chemin de votre logo Google

                      onPressed: () async {
                        // final result = await authViewModel.signInWithOAuth(OAuthProvider.google);
                         
                        // if (result) {
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => HomePage()),
                        //   );
                        // }
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

