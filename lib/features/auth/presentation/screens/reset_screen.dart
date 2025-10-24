import 'package:flutter/material.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/auth_appbar.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/reset_screen_body.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AuthAppBar(title: 'Reset password'),
      body: ResetScreenBody(),
    );
  }
}
