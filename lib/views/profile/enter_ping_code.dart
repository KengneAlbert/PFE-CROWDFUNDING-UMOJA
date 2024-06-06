import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';

class EnterPinPage extends StatefulWidget {
  @override
  _EnterPinPageState createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  List<bool> _pinDots = List.filled(5, false); // Track filled dots
  String _enteredPin = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156),),
        ),
        title: const Text('Enter PIN', style: TextStyle(color: Color(0xFF13B156)),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please enter your PIN",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _pinDots[index] ? Color(0xFF13B156) : Colors.grey[300],
                  ),
                ),
              ),
            ),
            Spacer(),
            CustomBouton(
              label: "Confirm",
              onPressed: () {
                WithdrawSuccessPopup();
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class WithdrawSuccessPopup extends StatelessWidget {
  const WithdrawSuccessPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF13B156).withOpacity(0.4),
                ),
              ),
              Icon(
                Icons.check,
                size: 40,
                color: Colors.white,
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF13B156).withOpacity(0.3),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 10,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF13B156).withOpacity(0.3),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 50,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF13B156).withOpacity(0.3),
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                right: 50,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF13B156).withOpacity(0.3),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Text(
            "Withdraw Successful!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "You have successfully withdraw from your wallet for \$300",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF13B156).withOpacity(0.4),
              padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              textStyle: TextStyle(fontSize: 16, color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text("OK"),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}