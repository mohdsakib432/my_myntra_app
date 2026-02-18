// ignore: file_names
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}


// final TextEditingController emailController = TextEditingController();
// final TextEditingController passwordController = TextEditingController();

// Column(
//   children: [
//     CustomTextField(
//       controller: emailController,
//       hintText: 'Email',
//       icon: Icons.email,
//     ),
//     SizedBox(height: 16),
//     CustomTextField(
//       controller: passwordController,
//       hintText: 'Password',
//       icon: Icons.lock,
//       obscureText: true,
//     ),
//   ],
// )