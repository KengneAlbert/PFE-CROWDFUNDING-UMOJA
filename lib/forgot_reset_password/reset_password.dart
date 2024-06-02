import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';
import 'package:provider/provider.dart';
import 'package:umoja/onboarding_screen/Auth/Auth.dart';
import 'reset_password_successful.dart';
//import 'verification_code.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _rememberMe = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Image illustrative (optionnelle)
              Image.asset('assets/images/Forgot2.png'),
            

              const SizedBox(height: 20),
              const Text(
                'Create a new password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Champ du nouveau mot de passe
              TextFormField(
                controller: _newPasswordController,
                decoration: const InputDecoration(
                  labelText: 'New Password*',
                ),
                obscureText: true,
                validator: (value) {
                  // Validation du mot de passe
                },
              ),

              const SizedBox(height: 20),

              // Champ de confirmation du mot de passe 
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password*',
                ),
                obscureText: true,
                validator: (value) {
                  // Validation de la confirmation du mot de passe
                },
              ),

              const SizedBox(height: 10),

              // Checkbox "Se souvenir de moi"
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) => setState(() => _rememberMe = value!),
                  ),
                  const Text('Remember me'),
                ],
              ),

              const SizedBox(height: 20),

              // Bouton "Enregistrer"
              CustomBouton(
                label: "Save",
                onPressed:()async{
                  // if (_formKey.currentState!.validate()) {
                  //     final bool result = await authService.signInWithEmailAndPassword(
                  //             _emailController.text,
                  //             _passwordController.text,
                  //         );
                  //       if(result){
                  //         Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => SelectCountryPage(),
                  //           ),
                  //         );
                  //       }
                     
                  //   }
                  Navigator.push(context, MaterialPageRoute(builder:(context) => ResetPasswordSuccessful()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}