import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/core/di/auth_di.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/register_screen_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthDi.createCubit(),
      child: const Scaffold(
        body: RegisterScreenBody(),
      ),
    );
  }
}
