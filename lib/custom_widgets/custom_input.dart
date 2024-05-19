import 'package:flutter/material.dart';

// Widget personnalisé pour les champs de saisie
class CustomInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? errorText;
  final String? hintText;
  final TextInputType? keyboardType;
  final dynamic icon;
  final String? Function(String?)? validator;

  const CustomInput({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.icon,
    this.validator,
    this.errorText,
    this.hintText,
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
          hintText: hintText,
          errorText: errorText,
          // Bordure lorsque les conditions sont respectées
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF13B156)),
          ),
          suffixIcon:  icon != null && icon is IconData ? Icon(icon, color: Color(0xFF13B156),) : null,
        ),
        validator: validator,
      ),
    );
  }
}