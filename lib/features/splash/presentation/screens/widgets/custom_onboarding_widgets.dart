import 'package:flutter/material.dart';

class CustomOnboardingWidget extends StatelessWidget {
  final String imagePath;
  final String text;

  const CustomOnboardingWidget(
      {super.key, required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          const SizedBox(height: 40),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
