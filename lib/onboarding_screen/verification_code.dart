import 'package:flutter/material.dart';
import 'dart:async';


class VerificationCodePage extends StatefulWidget {
  final String phoneNumber; // Numéro de téléphone auquel le code a été envoyé

  const VerificationCodePage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  // Contrôleurs pour les champs de saisie du code
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Code has been send to ${widget.phoneNumber}'),
            const SizedBox(height: 20),
            // Champs de saisie du code
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var controller in _codeControllers)
                  SizedBox(
                    width: 50,
                    child: TextField(
                      controller: controller,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
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
            ElevatedButton(
              onPressed: () {
                // TODO: Vérifier le code saisi
              },
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}