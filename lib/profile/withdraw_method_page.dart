import 'package:flutter/material.dart';

class WithdrawMethodPage extends StatefulWidget {
  @override
  _WithdrawMethodPageState createState() => _WithdrawMethodPageState();
}

class _WithdrawMethodPageState extends State<WithdrawMethodPage> {
  int _selectedMethod = -1; // No method selected initially

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("Withdraw"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Add New Card",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Withdraw Method",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            buildPaymentMethodCard(
              icon: Image.asset("assets/paypal.png"),
              title: "PayPal",
              value: 0,
            ),
            buildPaymentMethodCard(
              icon: Image.asset("assets/google_pay.png"),
              title: "Google Pay",
              value: 1,
            ),
            buildPaymentMethodCard(
              icon: Image.asset("assets/apple_pay.png"),
              title: "Apple Pay",
              value: 2,
            ),
            SizedBox(height: 16),
            Text(
              "Pay with Debit/Credit Card",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            buildPaymentMethodCard(
              icon: Image.asset("assets/visa.png"),
              title: "•••• •••• •••• 4679",
              value: 3,
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