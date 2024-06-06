import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';
import 'package:umoja/views/home/page.dart';

class SelectInterestPage extends StatefulWidget {
  const SelectInterestPage({Key? key}) : super(key: key);

  @override
  _SelectInterestPageState createState() => _SelectInterestPageState();
}

class _SelectInterestPageState extends State<SelectInterestPage> {
  bool _showSuccessDialog = false;

  void _onContinuePressed() {
    setState(() {
      _showSuccessDialog = true;
    });
  }

  void _onHomePressed() {
    // TODO: Navigate to home screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Select Your Interest'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Choose your interest to donate. Don\'t worry, you can always change it later.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.0),
            // Placeholder for interest selection grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                children: List.generate(
                  4,
                  (index) => Container(
                    color: Colors.green, // Replace with your desired color
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            CustomBouton(
              label: "Continue",
              onPressed: _onContinuePressed,
              )
          ],
        ),
      ),
      // Success Dialog
      bottomSheet: _showSuccessDialog
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 64.0, color: Colors.green),
                  SizedBox(height: 16.0),
                  Text(
                    'Great!',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Your account has been created successfully',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.0),
                  CustomBouton(
                    label: "Go to Home",
                    onPressed: _onHomePressed,
                  )
                ],
              ),
            )
          : null,
    );
  }
}