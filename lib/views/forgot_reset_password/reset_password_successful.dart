import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';
import 'package:umoja/views/home/page.dart';

class ResetPasswordSuccessful extends StatelessWidget {
  const ResetPasswordSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    child: Image.asset("asset/images/logo_mini.png"),
                  ),           
                  Text(
                    "Congratulation !",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF13B156)
                    ),
                    ),
              
                  const SizedBox(height: 20,),
              
                  Text(
                    "Your account is ready to use",
                    ),
                  
                  const SizedBox(height: 20,),
              
                  CustomBouton(
                    label: "Go to Homepage",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context) => HomePage()));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}