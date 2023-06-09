import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgpt/widgets/frosted_glass.dart';

class SupportCard extends StatelessWidget {
  final String title;
  final String disc;
  final String imgSrc;
  final Color color;

  const SupportCard({
    super.key,
    required this.title,
    required this.disc,
    required this.imgSrc,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: FrostedGlass(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            color: color.withOpacity(0.6),
          ),
          height: 140,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  imgSrc,
                  width: MediaQuery.of(context).size.width * 0.35,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      disc,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white54,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
