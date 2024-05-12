import 'package:flutter/material.dart';

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
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut aliquam, purus sit amet luctus venenatis, lectus magna fringilla urna, porttitor.",
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF13B156), // Green background
                          minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 
                                          MediaQuery.of(context).size.height * 0.06), // 80% width, 15% height
                        ),

                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context) => OnboardingPageTwo()));
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white, 
                      ),
                      ),
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