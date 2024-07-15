/////////////////vrai haut/////////
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';
import 'package:umoja/custom_widgets/custom_select_items.dart';
import 'package:umoja/models/cinetpay.dart';
import 'package:umoja/viewmodels/finance/cinetpay_viewModel.dart';
import 'package:umoja/viewmodels/finance/top_up_method_payment_viewModel.dart';
import 'package:umoja/viewmodels/finance/stripe_viewModel.dart';
import 'package:umoja/viewmodels/finance/wallet_viewModel.dart';
import 'package:umoja/services/database_service.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:umoja/views/profile/add_new_card.dart';
import 'package:umoja/views/profile/enter_ping_code.dart';

class TopUpMethodPage extends ConsumerStatefulWidget {
  final double amount;

  const TopUpMethodPage({Key? key, required this.amount}) : super(key: key);

  @override
  _TopUpMethodPageState createState() => _TopUpMethodPageState();
}

class _TopUpMethodPageState extends ConsumerState<TopUpMethodPage> {
  int? _selectedPaymentMethod;
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final topUpState = ref.watch(topUpViewModelProvider);
    final topUpViewModel = ref.read(topUpViewModelProvider.notifier);
    final paymentViewModel = ref.watch(paymentProvider);
    final walletViewModel = ref.read(walletViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156)),
        ),
        title: const Text('Top up'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.qr_code_scanner, color: Color(0xFF13B156)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Top up Method',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNewCardPage()));
                  },
                  child: Text("Add new card",
                      style: TextStyle(color: Color(0xFF13B156))),
                )
              ],
            ),
            const SizedBox(height: 16),
            SelectItems(
              icon: const Icon(Icons.payment),
              title: 'Stripe',
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
              icon: const Icon(Icons.payment),
              title: 'CinetPay',
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
              icon: const Icon(Icons.account_balance_wallet),
              title: 'Google Pay',
              value: 2,
              isSelected: _selectedPaymentMethod == 2,
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
              value: 3,
              isSelected: _selectedPaymentMethod == 3,
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
              value: 4,
              isSelected: _selectedPaymentMethod == 4,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            const SizedBox(height: 16),
            SelectItems(
              icon: const Icon(Icons.credit_card),
              title: '•••• •••• •••• 1234',
              value: 5,
              isSelected: _selectedPaymentMethod == 5,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            const SizedBox(height: 16),
            CustomBouton(
              label: "Continue",
              onPressed: () async {
                String? uid = FirebaseAuth.instance.currentUser?.uid;
                if (_selectedPaymentMethod == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a payment method.'),
                    ),
                  );
                  return;
                }

                if (_selectedPaymentMethod == 0) {
                  try {
                    final paymentIntent = await ref.read(stripeProvider).createPaymentIntent(widget.amount.toInt());
                    await Stripe.instance.initPaymentSheet(
                      paymentSheetParameters: SetupPaymentSheetParameters(
                        paymentIntentClientSecret: paymentIntent['client_secret'],
                        merchantDisplayName: 'Your Merchant Name',
                      ),
                    );
                    await Stripe.instance.presentPaymentSheet();
                    // Update wallet balance
                    walletViewModel.topUp(widget.amount);
                    await _databaseService.create('users/$uid/portefeuille', {
                      'amount': widget.amount,
                      'timestamp': FieldValue.serverTimestamp(),
                      'transactionId': Uuid().v4(),
                      'status': 'success',
                    });
                  } catch (e) {
                    // Handle errors
                    print(e);
                  }
                } else if (_selectedPaymentMethod == 1) {
                  final paymentInfo = PaymentInfo(
                    apikey: '753027887668989d446a339.48884425',
                    siteId: '5875404',
                    notifyUrl: '',
                    amount: widget.amount.toInt(),
                    currency: 'XAF',
                    description: 'Description du paiement',
                    channels: 'ALL',
                  );

                  try {
                    final paymentUrl = await paymentViewModel.initiatePayment(paymentInfo);
                    if (await canLaunch(paymentUrl)) {
                      await launch(paymentUrl);
                      // Update wallet balance
                      walletViewModel.topUp(widget.amount);
                      await _databaseService.create('users/$uid/portefeuille', {
                        'amount': widget.amount,
                        'timestamp': FieldValue.serverTimestamp(),
                        'transactionId': paymentInfo.transactionId,
                        'status': 'pending',
                      });
                      // await _databaseService.create('MyWallet', {
                      //   'amount': widget.amount,
                      //   'timestamp': FieldValue.serverTimestamp(),
                      //   'transactionId': paymentInfo.transactionId,
                      //   'status': 'pending',
                      // });
                    } else {
                      throw 'Could not launch $paymentUrl';
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                      ),
                    );
                  }
                } else if (_selectedPaymentMethod == 2) {
                  final paymentIntent = await ref.read(stripeProvider).createPaymentIntent(widget.amount.toInt());
                  await Stripe.instance.initPaymentSheet(
                    paymentSheetParameters: SetupPaymentSheetParameters(
                      paymentIntentClientSecret: paymentIntent['client_secret'],
                      merchantDisplayName: 'Your Merchant Name',
                      googlePay: PaymentSheetGooglePay(
                        merchantCountryCode: 'US',
                        currencyCode: 'usd',
                      ),
                    ),
                  );
                  await Stripe.instance.presentPaymentSheet();
                  // Update wallet balance
                  walletViewModel.topUp(widget.amount);
                 
                } else if (_selectedPaymentMethod == 3) {
                  final paymentIntent = await ref.read(stripeProvider).createPaymentIntent(widget.amount.toInt());
                  await Stripe.instance.initPaymentSheet(
                    paymentSheetParameters: SetupPaymentSheetParameters(
                      paymentIntentClientSecret: paymentIntent['client_secret'],
                      merchantDisplayName: 'Your Merchant Name',
                      applePay: PaymentSheetApplePay(
                        merchantCountryCode: 'US',
                      ),
                    ),
                  );
                  await Stripe.instance.presentPaymentSheet();
                  // Update wallet balance
                  walletViewModel.topUp(widget.amount);
                } else if (_selectedPaymentMethod == 4 || _selectedPaymentMethod == 5) {
                  // Credit/Debit card payment logic
                  walletViewModel.topUp(widget.amount);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}