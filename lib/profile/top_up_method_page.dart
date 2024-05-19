import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_select_items.dart';

class TopUpMethodPage extends StatefulWidget {
  const TopUpMethodPage({Key? key}) : super(key: key);

  @override
  State<TopUpMethodPage> createState() => _TopUpMethodPageState();
}

class _TopUpMethodPageState extends State<TopUpMethodPage> {
  int? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Top up'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.qr_code_scanner),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Top up Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SelectItems(
              icon: const Icon(Icons.payment),
              title: 'PayPal',
              value: 0,
              isSelected: _selectedPaymentMethod == 0,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            const SizedBox(height: 16),
            SelectItems(
              icon: const Icon(Icons.account_balance_wallet),
              title: 'Google Pay',
              value: 1,
              isSelected: _selectedPaymentMethod == 1,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            const SizedBox(height: 16),
            SelectItems(
              icon: const Icon(Icons.apple),
              title: 'Apple Pay',
              value: 2,
              isSelected: _selectedPaymentMethod == 2,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Pay with Debit/Credit Card',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SelectItems(
              icon: const Icon(Icons.credit_card),
              title: '•••• •••• •••• 4679',
              value: 3,
              isSelected: _selectedPaymentMethod == 3,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
