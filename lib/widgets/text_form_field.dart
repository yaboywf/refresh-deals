import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;
  final bool enabled;
  final TextInputType inputType;

  const CustomTextFormField({
    super.key,
    this.validator,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.enabled = true,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      controller: controller,
      enabled: enabled,
      validator: validator ?? (value) {
        if (inputType == TextInputType.emailAddress) {
          if (value == null || value.isEmpty) return 'Please enter your email';
          String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(value)) return 'Please enter a valid email';
          return null;

        } else if (inputType == TextInputType.text) {
          if (value == null || value.isEmpty) return 'Please enter your ${hintText.toLowerCase()}';
          return null;
        }

        return null;
      },
      obscureText: obscureText,
      keyboardType: inputType,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.red),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        fillColor: Colors.transparent,
        filled: true,
        hintText: "Enter $hintText",
        hintStyle: TextStyle(fontSize: 14.0, color: enabled ? Colors.black : Colors.grey),
      ),
    );
  }
}
