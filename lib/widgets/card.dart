import 'package:flutter/material.dart';
import 'package:sgpt/data/constants.dart';
import 'package:sgpt/widgets/frosted_glass.dart';

import '../model/app_data_model.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.data,
    required this.pageRoute,
  });

  final AppData data;

  final Widget pageRoute;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        // shape: ,
        backgroundColor: Colors.black.withOpacity(0.2),
        showDragHandle: false,
        useSafeArea: true,
        context: context,
        builder: (context) => FrostedGlass(child: pageRoute),
      ),
      child: FrostedGlass(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(int.parse(data.color)).withOpacity(0.7),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
                child: Container(
                  decoration: BoxDecoration(
                    color: itextColor == Colors.black
                        ? Colors.black.withOpacity(0.8)
                        : Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      IconData(
                        int.parse(data.icon),
                        fontFamily: 'MaterialIcons',
                      ),
                      color: itextColor == Colors.black
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black.withOpacity(0.7),
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.disc,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
