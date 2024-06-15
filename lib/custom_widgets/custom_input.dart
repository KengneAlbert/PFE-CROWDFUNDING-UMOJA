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
  final bool enabled;

  const CustomInput({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.icon,
    this.validator,
    this.errorText,
    this.hintText,
    this.enabled = true,
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
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF13B156)),
          ),
          suffixIcon: icon != null && icon is IconData
              ? Icon(icon, color: Color(0xFF13B156))
              : null,
        ),
        validator: validator,
        enabled: enabled,
      ),
    );
  }
}

class CustomBouton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const CustomBouton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF13B156),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}