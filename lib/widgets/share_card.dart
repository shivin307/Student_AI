import 'package:flutter/material.dart';
import 'package:sgpt/data/constants.dart';
import 'package:sgpt/widgets/support_card.dart';
import 'package:share_plus/share_plus.dart';

class ShareCard extends StatelessWidget {
  const ShareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final box = context.findRenderObject() as RenderBox?;

        Share.share(
            'https://github.com/shivin307/Student_AI/releases/download/v2.0.0/Student_AI.apk',
            subject: 'Share App',
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
      },
      child: const SupportCard(
        title: "Share",
        disc: "Tell the World About Us",
        imgSrc: "assets/images/share.svg",
        color: isuppoerCard1,
      ),
    );
  }
}
