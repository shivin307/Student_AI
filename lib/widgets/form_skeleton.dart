import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FormSkeleton extends StatelessWidget {
  final String title;
  const FormSkeleton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF9A9797),
          Color(0xFFF4F4F4),
          Color(0xFF9A9797),
        ],
        begin: Alignment.topLeft,
        end: Alignment(2.0, 0.3),
        stops: [
          0.2,
          0.3,
          0.4,
        ],
        tileMode: TileMode.mirror,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 10),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          for (var i = 0; i < 4; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFF9A9797),
                        ),
                        height: 22,
                        width: 48,
                      )),
                  Container(
                    height: 53,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF9A9797),
                    ),
                  )
                ],
              ),
            ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 48,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xFF9A9797),
            ),
          )
        ],
      ),
    );
  }
}
