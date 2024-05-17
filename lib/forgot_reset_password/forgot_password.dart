import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';

import 'reset_password.dart';
import 'verification_code.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // Variables pour gérer l'option de récupération sélectionnée (SMS ou Email)
  bool _isSmsSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            Image.asset('assets/images/Forgot1.png'),
            
            const SizedBox(height: 20),

            const Text(
              'Select which contact details should we use to reset your password',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            // Option SMS
            InkWell(
              onTap: () {
                setState(() {
                  _isSmsSelected = true;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: _isSmsSelected ? Colors.green : Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.message),
                    const SizedBox(width: 15),
                    Text(
                      'via SMS: +6282 ********39',
                      style: TextStyle(
                        color: _isSmsSelected ? Colors.green : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Option Email
            InkWell(
              onTap: () {
                setState(() {
                  _isSmsSelected = false;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: !_isSmsSelected ? Colors.green : Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.email),
                    const SizedBox(width: 15),
                    Text(
                      'via Email: ex***le@yourdomain.com',
                      style: TextStyle(
                        color: !_isSmsSelected ? Colors.green : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            CustomBouton(
              label: "Continue",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => VerificationCodePage(phoneNumber:'659070872')));
              },
            )
          ],
        ),
      ),
    );
  }
}