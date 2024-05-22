import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';
import 'package:umoja/custom_widgets/custom_input.dart';
import 'package:umoja/profile/enter_ping_code.dart';

class WithdrawConfirmPage extends StatefulWidget {
  @override
  _WithdrawConfirmPageState createState() => _WithdrawConfirmPageState();
}

class _WithdrawConfirmPageState extends State<WithdrawConfirmPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

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
        title: Text("Withdraw", style: TextStyle(color: Color(0xFF13B156),),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Center(
                  child: Image.asset("assets/images/Check_mail.png"),
                ),
                SizedBox(height: 32),
                CustomInput(
                  label: "PayPal Email", 
                  controller: _emailController,
                  hintText: "adam.smith@yourdomain.com",
                  icon: Icon(Icons.email),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!value.contains('@')) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                CustomBouton(
                  label: "Continue",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EnterPinPage()));
                    }
                  },
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