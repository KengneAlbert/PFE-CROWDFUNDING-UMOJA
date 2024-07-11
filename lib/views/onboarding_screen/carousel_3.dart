import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';

import 'sign_method.dart';
import 'sign_up.dart';

class OnboardingPageThree extends StatefulWidget {
  const OnboardingPageThree({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPageThree> {
  // Add state variables for page index, etc. if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Illustration
              Expanded(
                child: Image.asset('assets/images/Frame3.png'), 
              ),

              // Text Content
              const Text(
                "Trusted, transparent, and effective in sharing kindness",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF13B156),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const Text(
                "Réalisez vos rêves. Ensemble",
                textAlign: TextAlign.center,
              ),

              // Page Indicator
              // (Implement dots or any other indicator style)

              // Buttons
              const SizedBox(height: 30),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Handle skip action
                    },
                    child: const Text(
                      "Skip",
                       style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF13B156),
                      ),
                    ),
                  ),
                  
                  CustomBouton(
                    label: "Next", 
                    onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder:(context) => SignMethod()));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}