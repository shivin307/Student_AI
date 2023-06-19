import 'package:flutter/material.dart';

import '../data/constants.dart';

class ServerIndicator extends StatefulWidget {
  final bool isServerUp;

  const ServerIndicator({
    super.key,
    required this.isServerUp,
  });

  @override
  State<ServerIndicator> createState() => _ServerIndicatorState();
}

class _ServerIndicatorState extends State<ServerIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(21),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Server",
              style: TextStyle(color: Colors.white, fontSize: 12)),
          const SizedBox(width: 8),
          Container(
            constraints: const BoxConstraints(maxWidth: 8, maxHeight: 8),
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: widget.isServerUp ? iserverUp : iserverDown,
            ),
          )
        ],
      ),
    );
  }
}
