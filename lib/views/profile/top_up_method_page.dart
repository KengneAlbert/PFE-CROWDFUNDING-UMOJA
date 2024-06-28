import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';
import 'package:umoja/custom_widgets/custom_select_items.dart';
import 'package:umoja/models/payment_method_model.dart';
import 'package:umoja/viewmodels/finance/top_up_method_payment_viewModel.dart';
import 'package:umoja/views/profile/add_new_card.dart';
import 'package:umoja/views/profile/enter_ping_code.dart';

class TopUpMethodPage extends ConsumerWidget {
  final TopUpViewModel topUpViewModel;

  const TopUpMethodPage({Key? key, required this.topUpViewModel})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topUpState = ref.watch(topUpViewModelProvider);

    final paymentMethods = [
      PaymentMethod(id: 0, title: 'PayPal', details: 'paypal_id'),
      PaymentMethod(id: 1, title: 'Google Pay', details: 'google_pay_id'),
      PaymentMethod(id: 2, title: 'Apple Pay', details: 'apple_pay_id'),
      PaymentMethod(id: 3, title: '•••• •••• •••• 4679', details: 'card_id'),
    ];

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
      body: Padding(
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => AddNewCardPage()));
                  },
                  child: Text("Add new card",
                      style: TextStyle(color: Color(0xFF13B156))),
                )
              ],
            ),
            const SizedBox(height: 16),
            for (final method in paymentMethods)
              SelectItems(
                icon: method.id == 3
                    ? const Icon(Icons.credit_card)
                    : const Icon(Icons.payment),
                title: method.title,
                value: method.id,
                isSelected: topUpState.selectedPaymentMethod?.id == method.id,
                onChanged: (value) {
                  ref
                      .read(topUpViewModelProvider.notifier)
                      .selectPaymentMethod(method);
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
            const Spacer(),
            CustomBouton(
              label: "Continu",
              onPressed: () {
                // if (topUpState.selectedPaymentMethod != null &&
                //     topUpState.paymentIntent != null) {
                  // ref
                  //     .read(topUpViewModelProvider.notifier)
                  //     .startPayment(topUpState.selectedPaymentMethod!.details!);
                  topUpViewModel.createPaymentIntent();
                  ref
                      .read(topUpViewModelProvider.notifier)
                      .startPayment(topUpState.selectedPaymentMethod!.details!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EnterPinPage()));
                // } 
                // else {
                //   // Afficher un message d'erreur à l'utilisateur
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //       content: Text(
                //           'Veuillez sélectionner une méthode de paiement et créer un PaymentIntent.')));
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class TopUpMethodPage extends ConsumerWidget {
//   final TopUpViewModel topUpViewModel; 

//   const TopUpMethodPage({Key? key, required this.topUpViewModel}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final topUpViewModel = ref.watch(topUpViewModelProvider);
//     final paymentMethods = [
//       PaymentMethod(id: 0, title: 'PayPal'),
//       PaymentMethod(id: 1, title: 'Google Pay'),
//       PaymentMethod(id: 2, title: 'Apple Pay'),
//       PaymentMethod(id: 3, title: '•••• •••• •••• 4679'),
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156)),
//         ),
//         title: const Text('Top up'),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.qr_code_scanner, color: Color(0xFF13B156)),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Select Top up Method',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewCardPage()));
//                   },
//                   child: Text("Add new card", style: TextStyle(color: Color(0xFF13B156))),
//                 )
//               ],
//             ),
//             const SizedBox(height: 16),
//             for (final method in paymentMethods)
//               SelectItems(
//                 icon: method.id == 3 ? const Icon(Icons.credit_card) : const Icon(Icons.payment),
//                 title: method.title,
//                 value: method.id,
//                 isSelected: topUpViewModel.selectedPaymentMethod?.id == method.id,
//                 onChanged: (value) {
//                   ref.read(topUpViewModelProvider.notifier).selectPaymentMethod(method);
//                 },
//               ),
//             const SizedBox(height: 16),
//             const Text(
//               'Pay with Debit/Credit Card',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Spacer(),
//             CustomBouton(
//               label: "Continu",
//               onPressed: () {
//                 if (topUpViewModel.selectedPaymentMethod != null && topUpViewModel.paymentIntent != null) {
//                     ref.read(topUpViewModelProvider.notifier).startPayment(topUpViewModel.selectedPaymentMethod!.details!);
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => EnterPinPage()));
//                   } else {
//                     // Afficher un message d'erreur à l'utilisateur
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez sélectionner une méthode de paiement et créer un PaymentIntent.')));
//                   }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:umoja/custom_widgets/custom_bouton.dart';
// import 'package:umoja/custom_widgets/custom_select_items.dart';
// import 'package:umoja/viewmodels/finance/stripe_payment_viewModel.dart';
// import 'package:umoja/viewmodels/finance/top_up_method_payment_viewModel.dart';
// import 'package:umoja/views/profile/add_new_card.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:umoja/services/payment_service.dart';
// import 'package:umoja/views/profile/enter_ping_code.dart';

// class TopUpMethodPage extends StatefulWidget {
//   const TopUpMethodPage({Key? key}) : super(key: key);

//   @override
//   State<TopUpMethodPage> createState() => _TopUpMethodPageState();
// }

// class _TopUpMethodPageState extends State<TopUpMethodPage> {
//   int? _selectedPaymentMethod;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156),),
//         ),
//         title: const Text('Top up'),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.qr_code_scanner, color: Color(0xFF13B156)),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Select Top up Method',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewCardPage()));
//                   }, 
//                   child: Text("Add new card", style: TextStyle(color: Color(0xFF13B156)),),
//                 )
//               ],
//             ),
//             const SizedBox(height: 16),
//             SelectItems(
//               icon: const Icon(Icons.payment),
//               title: 'PayPal',
//               value: 0,
//               isSelected: _selectedPaymentMethod == 0,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedPaymentMethod = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 16),
            
//             SelectItems(
//               icon: const Icon(Icons.account_balance_wallet),
//               title: 'Google Pay',
//               value: 1,
//               isSelected: _selectedPaymentMethod == 1,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedPaymentMethod = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 16),
//             SelectItems(
//               icon: const Icon(Icons.apple),
//               title: 'Apple Pay',
//               value: 2,
//               isSelected: _selectedPaymentMethod == 2,
//               onChanged: (value){
//                 setState(() {
//                   _selectedPaymentMethod = value;
//                 });
                
//               },
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Pay with Debit/Credit Card',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             SelectItems(
//               icon: const Icon(Icons.credit_card),
//               title: '•••• •••• •••• 4679',
//               value: 3,
//               isSelected: _selectedPaymentMethod == 3,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedPaymentMethod = value;
//                 });
//               },
//             ),
//             const Spacer(),
//             CustomBouton(
//               label: "Continu",
//               onPressed: () async{
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => EnterPinPage()));
//               },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
