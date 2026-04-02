import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/core/di/auth_di.dart';
import 'package:isharaapp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/auth_appbar.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/check_mail_screen_body.dart';

enum CheckMailFlow { forgotPassword, emailVerification }

class CheckMailScreen extends StatelessWidget {
  const CheckMailScreen({
    super.key,
    required this.email,
    this.flow = CheckMailFlow.forgotPassword,
  });

  final String email;
  final CheckMailFlow flow;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => AuthDi.createCubit(),
      child: Scaffold(
        appBar: const AuthAppBar(title: 'Reset password'),
        body: CheckMailScreenBody(
          email: email,
          flow: flow,
        ),
      ),
    );
  }
}
