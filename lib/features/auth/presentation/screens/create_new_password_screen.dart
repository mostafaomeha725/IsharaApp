import 'package:flutter/material.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/auth_appbar.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/create_new_password_screen_body.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AuthAppBar(title: 'Reset password'),
      body: CreateNewPasswordScreenBody(),
    );
  }
}
