import 'package:flutter/material.dart';

// Widget personnalisé pour les champs de saisie
class InputWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final IconData? icon;
  final String? Function(String?)? validator;

  const InputWidget({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          // border: OutlineInputBorder(),
          suffixIcon: icon != null ? Icon(icon, color: Color(0xFF13B156),) : null,
        ),
        validator: validator,
      ),
    );
  }
}