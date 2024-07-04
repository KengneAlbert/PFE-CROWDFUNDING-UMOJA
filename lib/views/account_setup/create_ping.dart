import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/viewmodels/registration_notifier.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';
import 'package:umoja/viewmodels/user_viewModel.dart';
import 'package:umoja/views/homepage/HomePage.dart';

class SetPinCodePage extends ConsumerWidget {
   static UserService userService = UserService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(registrationProvider);
    final registrationNotifier = ref.read(registrationProvider.notifier);
    final pinController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Set Your Pin Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Please set a 4-digit PIN code for your account.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            TextFormField(
              controller: pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 4,
              decoration: const InputDecoration(
                labelText: 'PIN Code',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a PIN code';
                }
                if (value.length != 4) {
                  return 'PIN code must be 4 digits';
                }
                return null;
              },
            ),
            const SizedBox(height: 32.0),
            CustomBouton(
              label: "Finish",
              onPressed: () async {
                if (pinController.text.length == 4) {
                  registrationNotifier.updateData('pin_code', int.parse(pinController.text));
                  showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                    );
                  await userService.createUserInFirestore(ref,  ref.read(registrationProvider));
                  Navigator.pop(context); // Remove the loading indicator
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:umoja/views/account_setup/select_interest_succes.dart';
// import 'package:umoja/custom_widgets/custom_bouton.dart';

// class CreatePinPage extends StatefulWidget {
//   const CreatePinPage({Key? key}) : super(key: key);

//   @override
//   _CreatePinPageState createState() => _CreatePinPageState();
// }

// class _CreatePinPageState extends State<CreatePinPage> {
//   List<String> _pin = [];
//   final _formKey = GlobalKey<FormState>();

//   void _addPinDigit(String digit) {
//     setState(() {
//       if (_pin.length < 4) {
//         _pin.add(digit);
//       }
//     });
//   }

//   void _removePinDigit() {
//     setState(() {
//       if (_pin.isNotEmpty) {
//         _pin.removeLast();
//       }
//     });
//   }

//   void _createPin() {
//     if (_formKey.currentState!.validate()) {
//       // TODO: Submit the PIN to your backend
//       // Navigator.push(context, MaterialPageRoute(builder: (context) => SelectInterestPage()));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: Text('Create Your PIN'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 'Please remember this PIN because it will be used when you want to top up, withdraw, or donate.',
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 32.0),
//               Text(
//                 'Create PIN',
//                 style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   4,
//                   (index) => Container(
//                     width: 20.0,
//                     height: 20.0,
//                     margin: EdgeInsets.symmetric(horizontal: 8.0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: _pin.length > index
//                           ? Colors.green
//                           : Colors.grey[300],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 32.0),

//               CustomBouton(
//                 label: "Create PIN",
//                 onPressed: _createPin,
//                 ),
  
//               SizedBox(height: 32.0),
//               Expanded(
//                 child: GridView.count(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 16.0,
//                   crossAxisSpacing: 16.0,
//                   children: [
//                     _buildNumberButton('1'),
//                     _buildNumberButton('2', label: 'ABC'),
//                     _buildNumberButton('3', label: 'DEF'),
//                     _buildNumberButton('4', label: 'GHI'),
//                     _buildNumberButton('5', label: 'JKL'),
//                     _buildNumberButton('6', label: 'MNO'),
//                     _buildNumberButton('7', label: 'PQRS'),
//                     _buildNumberButton('8', label: 'TUV'),
//                     _buildNumberButton('9', label: 'WXYZ'),
//                     _buildSymbolButton(),
//                     _buildNumberButton('0'),
//                     _buildDeleteButton(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNumberButton(String number, {String? label}) {
//     return ElevatedButton(
//       onPressed: () {
//         _addPinDigit(number);
//       },
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.all(16.0),
//         textStyle: TextStyle(fontSize: 20.0),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(number),
//           if (label != null) Text(label, style: TextStyle(fontSize: 12.0)),
//         ],
//       ),
//     );
//   }

//   Widget _buildSymbolButton() {
//     return ElevatedButton(
//       onPressed: () {
//         // TODO: Handle symbol input
//       },
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.all(16.0),
//         textStyle: TextStyle(fontSize: 20.0),
//       ),
//       child: Text('+ * #'),
//     );
//   }

//   Widget _buildDeleteButton() {
//     return ElevatedButton(
//       onPressed: _removePinDigit,
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.all(16.0),
//       ),
//       child: Icon(Icons.backspace),
//     );
//   }
// }