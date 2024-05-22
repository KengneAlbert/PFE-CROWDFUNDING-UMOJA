import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';
import 'package:umoja/custom_widgets/custom_select_items.dart';
import 'package:umoja/profile/enter_ping_code.dart';
import 'package:umoja/profile/withdraw_confirm_page.dart';

class WithdrawMethodPage extends StatefulWidget {
  const WithdrawMethodPage({Key? key}) : super(key: key);

  @override
  State<WithdrawMethodPage> createState() => _WithdrawMethodPageState();
}

class _WithdrawMethodPageState extends State<WithdrawMethodPage> {
  int? _selectedPaymentMethod;

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
        title: const Text('Withdraw', style: TextStyle(color: Color(0xFF13B156)),),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.qr_code_scanner, color: Color(0xFF13B156)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Withdraw Method',
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
            CustomBouton(
              label: "Continue",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WithdrawConfirmPage()));
              },
              ),
          ],
        ),
      ),
    );
  }
}
