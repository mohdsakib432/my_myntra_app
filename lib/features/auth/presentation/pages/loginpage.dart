import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_myntra_app/core/routes/app_routes.dart';
import 'package:my_myntra_app/core/utils/button/appbutton.dart';
import 'package:my_myntra_app/core/utils/textfield/apptextfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextField(
                controller: emailController,
                label: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: passwordController,
                label: 'Password',
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Login',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (kDebugMode) {
                      debugPrint(emailController.text);
                    }
                  }
                  if (kDebugMode) {
                    debugPrint(passwordController.text);

                    Navigator.pushReplacementNamed(context, AppRoutes.product);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
