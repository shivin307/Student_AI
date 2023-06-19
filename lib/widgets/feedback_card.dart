import 'package:flutter/material.dart';
import 'package:sgpt/data/constants.dart';
import 'package:sgpt/widgets/support_card.dart';
import 'package:wiredash/wiredash.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Wiredash.of(context).show();
      },
      child: const SupportCard(
        title: "Feedback",
        disc: "Feature Request, Issue, Suggestions or Anything",
        imgSrc: "assets/images/feedback.svg",
        color: isuppoerCard3,
      ),
    );
  }
}
