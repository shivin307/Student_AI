import 'package:flutter/material.dart';
import 'package:sgpt/data/constants.dart';
import 'package:sgpt/widgets/frosted_glass.dart';

import '../data/icons.dart';
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
        showDragHandle: true,
        useSafeArea: true,
        context: context,
        builder: (context) => FrostedGlass(child: pageRoute),
      ),
      child: FrostedGlass(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(int.parse(data.color)).withOpacity(0.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      icons[data.icon],
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                        color: Colors.black.withOpacity(0.9),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.disc,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 15,
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
