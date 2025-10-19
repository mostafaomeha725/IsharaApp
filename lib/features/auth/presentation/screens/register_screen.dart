import 'package:flutter/material.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/register_screen_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RegisterScreenBody(),
    );
  }
}
