import 'package:flutter/material.dart';

class TopUpMethodPage extends StatefulWidget {
  @override
  _TopUpMethodPageState createState() => _TopUpMethodPageState();
}

class _TopUpMethodPageState extends State<TopUpMethodPage> {
  int _selectedMethod = -1; // No method selected initially

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("Top up"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.qr_code_scanner),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Top up Method",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            buildPaymentMethodCard(
              icon: Image.asset("assets/images/Cancel.png"),
              title: "PayPal",
              value: 0,
            ),
            buildPaymentMethodCard(
              icon: Image.asset("assets/images/logo_mini.png"),
              title: "Google Pay",
              value: 1,
            ),
            buildPaymentMethodCard(
              icon: Image.asset("assets/images/logo_mini.png"),
              title: "Apple Pay",
              value: 2,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle continue button press
                // ...
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: Text("Continue"),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentMethodCard({
    required Widget icon,
    required String title,
    required int value,
  }) {
    return Card(
      child: ListTile(
        leading: icon,
        title: Text(title),
        trailing: Radio<int>(
          value: value,
          groupValue: _selectedMethod,
          onChanged: (int? newValue) {
            setState(() {
              _selectedMethod = newValue!;
            });
          },
        ),
      ),
    );
  }
}