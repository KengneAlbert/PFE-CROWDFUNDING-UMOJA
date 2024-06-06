import 'package:flutter/material.dart';
import 'package:umoja/custom_widgets/custom_bouton.dart';
import 'dart:async';

import 'reset_password.dart';

class VerificationCodePage extends StatefulWidget {
  final String phoneNumber; // Numéro de téléphone auquel le code a été envoyé

  const VerificationCodePage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  // Contrôleurs pour les champs de saisie du code
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _codeControllers =
      List.generate(4, (index) => TextEditingController());

  // Variable pour le compte à rebours
  int _countdownSeconds = 56;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  // Fonction pour démarrer le compte à rebours
  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownSeconds > 0) {
          _countdownSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  // Fonction pour déplacer le focus vers le prochain champ
  void _nextField(int index) {
    if (index < _focusNodes.length - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 150,),
              Text('Code has been send to ${widget.phoneNumber}'),
              const SizedBox(height: 20),
              // Champs de saisie du code
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < _codeControllers.length; i++)
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: _codeControllers[i],
                        focusNode: _focusNodes[i], // Affecter le FocusNode au TextField
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (text) {
                          if (text.length == 1) {
                            _nextField(i); // Déplace le focus vers le prochain champ
                          }
                        },
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              // Message pour renvoyer le code
              Text(
                'Resend code in $_countdownSeconds s',
                style: TextStyle(color: Colors.green),
              ),
              const SizedBox(height: 40),
              // Bouton de vérification
              CustomBouton(
                label: "Verify",
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordPage()));
                },
                )
            ],
          ),
        ),
      ),
    );
  }
}