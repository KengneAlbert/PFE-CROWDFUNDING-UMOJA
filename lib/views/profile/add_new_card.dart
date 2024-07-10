// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:umoja/custom_widgets/custom_bouton.dart';
// import 'package:umoja/services/payment_service.dart';

// class AddNewCardPage extends StatefulWidget {
//   const AddNewCardPage({Key? key}) : super(key: key);

//   @override
//   State<AddNewCardPage> createState() => _AddNewCardPageState();
// }

// class _AddNewCardPageState extends State<AddNewCardPage> {
//   final _formKey = GlobalKey<FormState>();
//   String? _cardNumber;
//   String? _expiryDate;
//   String? _cvc;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156)),
//         ),
//         title: const Text('Add New Card'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Card Number'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your card number';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _cardNumber = value;
//                 },
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your expiry date';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _expiryDate = value;
//                 },
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'CVC'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your CVC';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _cvc = value;
//                 },
//               ),
//               const SizedBox(height: 16),
//               CustomBouton(
//                 label: "Add Card",
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     try {
//                       // Créez un objet CardDetails
//                       final cardDetails = CardDetails(
//                         number: _cardNumber!,
//                         expirationMonth: int.parse(_expiryDate!.split('/')[0]), // Correction de l'erreur
//                         expirationYear: int.parse(_expiryDate!.split('/')[1]) + 2000, // Correction de l'erreur
//                         cvc: _cvc!,
//                       );
//                       // Créez un PaymentMethod avec CardDetails
//                       final paymentMethod = await Stripe.instance.createPaymentMethod(
//                         params: PaymentMethodParams.card( // Correction de l'erreur
//                           card: cardDetails,
//                         ),
//                       );
//                       if (paymentMethod.paymentMethod!.id != null) {
//                         // Ajoutez le PaymentMethod à Firestore ou à votre système de gestion des paiements
//                         // Vous pouvez utiliser le service PaymentService pour cela
//                         final success = await PaymentService().addPaymentMethod(paymentMethod.paymentMethod!.id!);
//                         if (success) {
//                           // Redirigez l'utilisateur vers une page de succès
//                           Navigator.pop(context);
//                         } else {
//                           // Affichez un message d'erreur si l'ajout du PaymentMethod a échoué
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Failed to add payment method')),
//                           );
//                         }
//                       } else {
//                         // Affichez un message d'erreur si l'ajout du PaymentMethod a échoué
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Failed to add payment method')),
//                         );
//                       }
//                     } catch (e) {
//                       // Affichez un message d'erreur si une exception s'est produite
//                       print('Error adding card: ${e.toString()}');
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Error adding card: ${e.toString()}')),
//                       );
//                     }
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart'as bouton;
import 'package:umoja/custom_widgets/custom_input.dart';
import 'package:umoja/views/profile/top_up_method_page.dart';

class AddNewCardPage extends StatefulWidget {
  @override
  _AddNewCardPageState createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderNameController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Color(0xFF13B156)),
        ),
        title: Text("Add New Card"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.qr_code_scanner, color: Color(0xFF13B156)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: SvgPicture.asset("assets/images/Card.svg")),
                SizedBox(height: 24),
                CustomInput(
                  label: "Full Name*", 
                  hintText: "Albert Kengne",
                  controller: _cardHolderNameController,
                  validator:(value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your full name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                CustomInput(
                  label: "Card Number*", 
                  hintText: "4637 2639 4738 4679",
                  controller: _cardNumberController,
                  icon: Icons.credit_card,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your card number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                
                        CustomInput(
                          label: "Expiry Date*", 
                          hintText: "02/30", 
                          controller: _expiryDateController,
                          validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter the expiry date";
                                }
                                return null;
                              },
                          icon: IconButton(
                              onPressed: () {
                                // Show a date picker
                                // ...
                              },
                              icon: Icon(Icons.calendar_today),
                            ),
                        ),
                        SizedBox(width: 24),
                        CustomInput(
                          label: "CVV*", 
                          hintText: "180",
                          controller: _cvvController,
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return "Please enter the CVV";
                            }
                            return null;
                          },
                        ),  
                
                SizedBox(height: 32),
                
                CustomBouton(
                  label: "Add New Card", 
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process the form data and add the new card
                      // ...
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => TopUpMethodPage()));
                    };
                  }
                ),

                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}