import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final String placeholder;
  final bool isObscure;
  final TextEditingController controller;
  const AuthField({super.key, this.hintText = "", required this.placeholder,  this.isObscure = false, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: placeholder,
      ),
      validator: (value) {
        if(value == null || value.isEmpty) {
          return 'This field is required';
        } 
        return null;
      },
    );
  }
}