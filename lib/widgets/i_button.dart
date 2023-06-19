import 'package:flutter/material.dart';

import 'info_card.dart';

class IButton extends StatelessWidget {
  const IButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return const infoCard();
          }),
      child: const SizedBox(
        width: 35,
        child: Icon(Icons.info, color: Colors.white70),
      ),
    );
  }
}
