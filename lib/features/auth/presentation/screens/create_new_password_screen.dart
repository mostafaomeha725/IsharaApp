import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/core/di/auth_di.dart';
import 'package:isharaapp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/auth_appbar.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/create_new_password_screen_body.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => AuthDi.createCubit(),
      child: Scaffold(
        appBar: const AuthAppBar(title: 'Reset password'),
        body: CreateNewPasswordScreenBody(
          email: email,
          otp: otp,
        ),
      ),
    );
  }
}
