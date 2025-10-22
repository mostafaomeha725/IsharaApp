import 'package:flutter/material.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/auth_appbar.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/check_mail_screen_body.dart';

class CheckMailScreen extends StatelessWidget {
  const CheckMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AuthAppBar(title: 'Reset password'),
      body: CheckMailScreenBody(),
    );
  }
}
