import 'package:flutter/material.dart';

class QuizResult extends StatelessWidget {
  final int total;
  final int correct;

  const QuizResult({Key? key, required this.total, required this.correct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'RESULT',
              style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: correct == total
                    ? Colors.green
                    : correct / total >= 0.4
                        ? Colors.blue
                        : Colors.red,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.only(top: 50, bottom: 60, left: 60, right: 60),
              child: Text(
                '$correct/$total',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    fontFamily: Theme.of(context).textTheme.bodyLarge!.fontFamily),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
