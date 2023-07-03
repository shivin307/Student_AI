import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sgpt/data/constants.dart';
import 'package:sgpt/screens/quiz_result_screen.dart';

import '../data/secrets.dart';
import '../model/quiz_model.dart';
import '../service/api_service.dart';
import '../widgets/frosted_glass.dart';
import '../widgets/question_list_builder.dart';

class Quiz extends StatefulWidget {
  final String queryController;

  const Quiz({Key? key, required this.queryController}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool _isTyping = true;
  bool _isSubmitted = false;

  List<Question> questionJSON = [];
  List<String> answers = [];
  Map<int, String> selectedOptions = {};

  Future<void> fetchData(String qry) async {
    try {
      String fetchRes = await ApiService.fetchApi(apiKey, qry);

      setState(() {
        _isTyping = false;
      });

      Map<String, dynamic> quizJSON = jsonDecode(fetchRes);
      List<dynamic> questions = quizJSON['questions'];

      questionJSON = questions.map((e) {
        answers.add(e['answer']);
        return Question.fromJson(e);
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print("Quiz error: $e");
      }
    }
  }

  void _submitQuiz() {
    int correctAns = 0;
    for (var i = 0; i < answers.length; i++) {
      if (answers[i] == selectedOptions[i]) correctAns++;
    }
    setState(() {
      _isSubmitted = true;
    });

    // if (kDebugMode) {
    //   print(answers);
    //   print(selectedOptions);
    // }

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              QuizResult(total: answers.length, correct: correctAns),
        ));
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.queryController);
  }

  @override
  Widget build(BuildContext context) {
    return FrostedGlass(
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.6),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: const Text('MCQ Quiz'),
        ),
        body: _isTyping
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Generating Quiz...',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 16, horizontal: 80.0),
                      child: LinearProgressIndicator(
                        minHeight: 3,
                        color: Color.fromRGBO(173, 245, 40, 1),
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      QuestionListBuilder(
                          questionJSON: questionJSON,
                          selectedOptions: selectedOptions,
                          isSubmitted: _isSubmitted),
                      MaterialButton(
                        onPressed: _submitQuiz,
                        color: iwhite70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
