import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:umoja/account_setup/profile_page.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';
import 'package:umoja/custom_widgets/custom_input.dart';

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
        leading: Icon(Icons.arrow_back, color: Colors.green),
        title: Text("Add New Card"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.qr_code_scanner, color: Colors.green),
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