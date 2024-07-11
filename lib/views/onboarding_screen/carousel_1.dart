import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';

import 'carousel_2.dart';

class OnboardingPageOne extends StatefulWidget {
  const OnboardingPageOne({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPageOne> {
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
                child: Image.asset('assets/images/Frame.png'), 
              ),

              // Text Content
              const Text(
                "Donate easily, quickly, right on target all over the world",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF13B156),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const Text(
                "Une idée ? Un projet ? Trouvez votre communauté, trouvez le financement.",
                textAlign: TextAlign.center,
              ),

              // Page Indicator
              // (Implement dots or any other indicator style)

              // Buttons
              const SizedBox(height: 30),
              Column(
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
                       Navigator.push(context, MaterialPageRoute(builder:(context) => OnboardingPageTwo()));
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