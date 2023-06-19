import 'package:flutter/material.dart';
import 'package:sgpt/widgets/support_card.dart';

import '../data/constants.dart';

class RateCard extends StatelessWidget {
  const RateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const SupportCard(
        title: "Rate Us",
        disc: "Review on PlayStore",
        imgSrc: "assets/images/rate.svg",
        color: isuppoerCard2,
      ),
    );
  }
}
