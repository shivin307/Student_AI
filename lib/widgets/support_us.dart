import 'package:flutter/material.dart';
import 'package:sgpt/data/constants.dart';
import 'package:sgpt/widgets/feedback_card.dart';
import 'package:sgpt/widgets/rate_card.dart';
import 'package:sgpt/widgets/share_card.dart';

class SupportUs extends StatelessWidget {
  const SupportUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Support Us",
            style: TextStyle(
              color: itextColor.withOpacity(0.9),
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            ShareCard(),
            RateCard(),
            FeedbackCard(),
          ],
        ),
      ],
    );
  }
}
