import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';
import 'package:umoja/viewmodels/finance/top_up_method_payment_viewModel.dart';
import 'package:umoja/views/profile/top_up_method_page.dart';

class TopUpPage extends ConsumerStatefulWidget {
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends ConsumerState<TopUpPage> {
  @override
  Widget build(BuildContext context) {
    final topUpState = ref.watch(topUpViewModelProvider);
    final topUpViewModel = ref.read(topUpViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Top up"),
        actions: [
          Icon(Icons.more_vert, color: Color(0xFF13B156)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter the Amount",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color(0xFF13B156),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  "\$${topUpState.selectedAmount ?? 100}",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                buildAmountButton(ref, topUpState, 5),
                buildAmountButton(ref, topUpState, 10),
                buildAmountButton(ref, topUpState, 25),
                buildAmountButton(ref, topUpState, 50),
                buildAmountButton(ref, topUpState, 100),
                buildAmountButton(ref, topUpState, 200),
              ],
            ),
            Spacer(),
            CustomBouton(
              label: "Continue",
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopUpMethodPage(amount: topUpState.selectedAmount ?? 100),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildAmountButton(WidgetRef ref, TopUpState topUpState, int amount) {
    return ElevatedButton(
      onPressed: () {
        ref
            .read(topUpViewModelProvider.notifier)
            .selectAmount(amount.toDouble());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: topUpState.selectedAmount == amount.toDouble()
            ? Color(0xFF13B156)
            : Colors.white,
        foregroundColor: topUpState.selectedAmount == amount.toDouble()
            ? Colors.white
            : Color(0xFF13B156),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFF13B156), width: 2),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Text("\$$amount"),
    );
  }
}




////////////////////////////////////////////vh

// class TopUpPage extends ConsumerStatefulWidget {
//   @override
//   _TopUpPageState createState() => _TopUpPageState();
// }

// class _TopUpPageState extends ConsumerState<TopUpPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Créer le PaymentIntent dans initState
//     ref.read(topUpViewModelProvider.notifier).createPaymentIntent();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final topUpState = ref.watch(topUpViewModelProvider);
//     final topUpViewModel = ref.read(topUpViewModelProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156)),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text("Top up"),
//         actions: [
//           Icon(Icons.more_vert, color: Color(0xFF13B156)),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Enter the Amount",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16),
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: Color(0xFF13B156),
//                   width: 2,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   "\$${topUpState.selectedAmount ?? 100}",
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 24),
//             Wrap(
//               spacing: 16,
//               runSpacing: 16,
//               children: [
//                 buildAmountButton(ref, topUpState, 5),
//                 buildAmountButton(ref, topUpState, 10),
//                 buildAmountButton(ref, topUpState, 25),
//                 buildAmountButton(ref, topUpState, 50),
//                 buildAmountButton(ref, topUpState, 100),
//                 buildAmountButton(ref, topUpState, 200),
//               ],
//             ),
//             Spacer(),
//             CustomBouton(
//               label: "Continue",
//               onPressed: () {
//                 // Navigator.push(context, MaterialPageRoute(builder: (context) => TopUpMethodPage(topUpViewModel: topUpViewModel)));
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => TopUpMethodPage()));
//               },
//             ),
//             SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildAmountButton(WidgetRef ref, TopUpState topUpState, int amount) {
//     return ElevatedButton(
//       onPressed: () {
//         ref.read(topUpViewModelProvider.notifier).selectAmount(amount.toDouble());
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: topUpState.selectedAmount == amount.toDouble() ? Color(0xFF13B156) : Colors.white,
//         foregroundColor: topUpState.selectedAmount == amount.toDouble() ? Colors.white : Color(0xFF13B156),
//         padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//         textStyle: TextStyle(fontSize: 16),
//         shape: RoundedRectangleBorder(
//           side: BorderSide(color: Color(0xFF13B156), width: 2),
//           borderRadius: BorderRadius.circular(24),
//         ),
//       ),
//       child: Text("\$$amount"),
//     );
//   }
// }



