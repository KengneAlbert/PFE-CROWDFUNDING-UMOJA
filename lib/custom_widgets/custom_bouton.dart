import 'package:flutter/material.dart';

// Widget personnalisé pour les boutons
class CustomBouton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed; // onPressed est maintenant facultatif

  const CustomBouton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF13B156),
        minimumSize: Size(
          MediaQuery.of(context).size.width * 0.9, 
          MediaQuery.of(context).size.height * 0.06
        ), 
      ),
      onPressed: onPressed, // Appel de la fonction passée en argument si elle existe
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white, 
        ),
      ),
    );
  }
}