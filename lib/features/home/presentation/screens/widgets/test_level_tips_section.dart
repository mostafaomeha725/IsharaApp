import 'package:flutter/material.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

class TestLevelTipsSection extends StatelessWidget {
  const TestLevelTipsSection({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppText(
            'Tips:',
            style: font16w700.copyWith(color: textColor),
          ),
        ),
        _buildTipRow('Spell one letter at a time', textColor),
        _buildTipRow('Wait for green light to proceed', textColor),
      ],
    );
  }

  Widget _buildTipRow(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText('• ', style: font18w700.copyWith(color: textColor)),
          Expanded(
            child: AppText(
              text,
              style: font16w700.copyWith(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
