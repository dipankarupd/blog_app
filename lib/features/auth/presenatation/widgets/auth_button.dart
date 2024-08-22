import 'package:flutter/material.dart';

class AuthGradinetButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthGradinetButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(12)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(280, 68),
            padding: const EdgeInsets.all(16),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
