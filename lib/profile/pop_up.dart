import 'package:flutter/material.dart';

class PopUpPage extends StatefulWidget {
  @override
  _PopUpPageState createState() => _PopUpPageState();
}

class _PopUpPageState extends State<PopUpPage> {
  bool _showSuccessDialog = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Color(0xFF13B156)),
        ),
        title: Text('Top up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Payment method cards (e.g., PayPal, Credit Card)
            // ...
            SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  textStyle: TextStyle(color: Color(0xFF13B156)),
                ),
                child: Text('Add New Card'),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showSuccessDialog = true;
                  if (_showSuccessDialog)
                    Align(
                      alignment: Alignment.center,
                      child: SuccessDialog(),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF13B156),
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18, color: Colors.white),
              ),
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
      // Success Dialog
      // ... (implementation below)
    );
  }
}

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF13B156),
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Top up Successful!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'You have successfully top up your wallet for \$100',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF13B156),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
              textStyle: TextStyle(fontSize: 16, color: Colors.white),
            ),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

// Inside the TopUpPage class:

@override
Widget build(BuildContext context) {
  return Scaffold(
    // ... (rest of the code)

    // Success Dialog
    // ... (rest of the code)

    body: Stack(
      children: [
        // ... (rest of the body code)

        // Success Dialog
        // if (_showSuccessDialog)
        //   Align(
        //     alignment: Alignment.center,
        //     child: SuccessDialog(),
        //   ),
      ],
    ),
  );
}