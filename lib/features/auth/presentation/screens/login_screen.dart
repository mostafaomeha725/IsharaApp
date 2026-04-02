import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/core/di/auth_di.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthDi.createCubit(),
      child: const Scaffold(
        body: LoginScreenBody(),
      ),
    );
  }
}
