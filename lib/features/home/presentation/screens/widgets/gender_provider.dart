import 'package:flutter/material.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';

class GenderProvider extends StatefulWidget {
  final Widget child;

  const GenderProvider({super.key, required this.child});

  @override
  State<GenderProvider> createState() => _GenderProviderState();
}

class _GenderProviderState extends State<GenderProvider> {
  GenderTheme _gender = GenderTheme.boy;

  void _changeGender(GenderTheme newGender) {
    setState(() {
      _gender = newGender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GenderController(
      genderTheme: _gender,
      onGenderChanged: _changeGender,
      child: widget.child,
    );
  }
}
