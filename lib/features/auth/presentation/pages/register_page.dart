import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_myntra_app/core/routes/app_routes.dart';
import 'package:my_myntra_app/core/utils/button/custombutton.dart';
import 'package:my_myntra_app/core/utils/textfield/customtextfeild.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/auth_bloc/auth_event.dart';
import '../bloc/auth_bloc/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CustomTextField(controller: emailController, hintText: 'Email'),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: passwordController,
                  obscureText: true,
                  hintText: 'Password',
                ),
                const SizedBox(height: 20),

                state is AuthLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                            RegisterEvent(
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                        },
                        text: 'Register',
                      ),

                const SizedBox(height: 10),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: const Text("Already have account? Login"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
