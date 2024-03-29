import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sgpt/data/constants.dart';
import 'package:sgpt/data/secrets.dart';
import 'package:sgpt/screens/quiz_screen.dart';
import 'package:sgpt/widgets/form_skeleton.dart';
import 'package:sgpt/widgets/form_text_field.dart';

import '../data/globals.dart';
import '../service/api_service.dart';
import 'chat_screen.dart';
import 'mindmap_screen.dart';

// ignore: camel_case_types
class formScreen extends StatefulWidget {
  final String id;
  final String title;

  const formScreen({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  State<formScreen> createState() => _formScreenState();
}

// ignore: camel_case_types
class _formScreenState extends State<formScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formFields = {};
  Map<String, dynamic> submittedPrompt = {};
  late Map<String, TextEditingController> formFieldControllers = {};
  Map<String, dynamic> formDataById = {};

  Future fetchForm() async {
    try {
      Map<String, dynamic> r1 = await ApiService.getId(widget.id);
      setState(() {
        formDataById = r1['result'];
      });
      if (kDebugMode) {
        print(formDataById);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  @override
  void initState() {
    fetchForm().then((value) {
      // ignore: avoid_print
      print(formDataById);

      submittedPrompt['Prompt'] = formDataById['prompt'];

      formDataById['schema']['properties'].forEach((key, data) {
        formFields[key] = data;
        formFieldControllers[key] =
            TextEditingController(text: data['default'].toString());
      });
    });

    super.initState();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      formFieldControllers.forEach((key, textFieldMessage) {
        submittedPrompt[key] = textFieldMessage.text;
      });

      if (isAPIValidated && apiKey == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter a valid API Key'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          if (widget.id == 'mcq-type-quiz') {
            return Quiz(queryController: submittedPrompt.toString());
          } else if (widget.id == 'mindmap-generator') {
            return MindMap(data: submittedPrompt.toString());
          } else {
            return ChatScreen(
              chatController: submittedPrompt.toString(),
              isFormRoute: true,
            );
          }
        }));
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (BuildContext context) {
//               if (widget.id == 'mindmap-generator') {
//                 return MindMap(
//                   data: submittedPrompt.toString(),
//                 );
//               } else if (widget.id == 'mcq-type-quiz'){
//                 return Quiz(
//                   chatController: submittedPrompt.toString(),
//                   isFormRoute: true,
//                 );
//               }
//               else{
//                 if()
//
//               }
//             },
//           )
// ,
//         );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return formFields.isEmpty
        ? FormSkeleton(title: widget.title)
        : Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 10),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    for (var field in formFields.entries)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: FocusTraversalGroup(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  field.value['title'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              formTextField(
                                field: field,
                                formFieldControllers: formFieldControllers,
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    MaterialButton(
                      onPressed: _submitForm,
                      color: iradium.withOpacity(0.8),
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
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ),
          );
  }
}
