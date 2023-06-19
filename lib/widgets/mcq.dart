import 'package:flutter/material.dart';

import '../model/quiz_model.dart';

class MCQ extends StatefulWidget {
  MCQ(
      {Key? key,
      required this.mcq,
      required this.selectedOptions,
      required this.isSubmitted,
      required this.index})
      : super(key: key);

  final int index;
  final Question mcq;
  final Map<int, String> selectedOptions;
  bool isSubmitted;

  @override
  State<MCQ> createState() => _MCQState();
}

class _MCQState extends State<MCQ> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.mcq.question,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.mcq.options.length,
          itemBuilder: (context, index) {
            final option = widget.mcq.options[index];
            bool isSelected = _selectedOption == option;
            return RadioListTile<String>(
              activeColor: Colors.green,
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                option,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              subtitle: isSelected && widget.isSubmitted && widget.mcq.answer != _selectedOption
                  ? const Text(
                      'Wrong answer',
                      style: TextStyle(color: Colors.red),
                    )
                  : null,
              value: option,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                  widget.selectedOptions[widget.index] = _selectedOption!;
                  widget.isSubmitted = false;
                });
                // print(_selectedOption);
              },
            );
          },
        )
      ],
    );
  }
}
