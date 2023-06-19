import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgpt/data/constants.dart';
import 'package:sgpt/widgets/frosted_glass.dart';
import 'package:sgpt/widgets/message.dart';

import '../data/secrets.dart';
import '../service/api_service.dart';
import '../widgets/search_bar_home.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  //queryController
  final String chatController;
  bool isFormRoute;

  ChatScreen({required this.chatController, required this.isFormRoute});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController newChatController = TextEditingController();

  bool _isAITyping = false;

  List<MessageData> msgList = [];

  final ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }

  void sendMessage(String query) {
    if (widget.isFormRoute == false) {
      setState(() {
        msgList.insert(0, MessageData(text: query, sender: 'user'));
      });
    }
    setState(() {
      _isAITyping = true;
      widget.isFormRoute = false;
    });
    fetchMessage(query);
  }

  Future<void> fetchMessage(String query) async {
    try {
      String fetchRes = await ApiService.fetchApi(apiKey, query);
      // print(query);
      setState(() {
        msgList.insert(0, MessageData(text: fetchRes, sender: 'AI'));
        _isAITyping = false;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    sendMessage(widget.chatController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    //newQueryController

    return Stack(
      children: [
        Image.asset(
          'assets/images/chat_background.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Container(color: Colors.black12),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded),
            ),
            foregroundColor: Colors.black,
            title: Text(
              'Chat',
            ),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FrostedGlass(
                        child: AlertDialog(
                          insetPadding: EdgeInsets.all(16),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Clear this chat?',
                                style: TextStyle(
                                  fontWeight: fwBanner,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'This action cannot be undone. \nAre you sure you want to delete this chat?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  SizedBox(width: 15),
                                  ElevatedButton(
                                    child: Text('Clear chat'),
                                    onPressed: () => setState(
                                      () {
                                        msgList.clear();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: msgList.length,
                  itemBuilder: (context, index) => MessageData(
                    text: msgList[index].text,
                    sender: msgList[index].sender,
                  ),
                ),
              ),
              _isAITyping
                  ? Row(
                      children: [
                        Container(
                          margin:
                              const EdgeInsets.only(left: 8, right: 8, top: 12),
                          child: CircleAvatar(
                            radius: 15,
                            child: SvgPicture.asset(
                              'assets/openai_black.svg',
                              width: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: SpinKitThreeInOut(
                                  color: Colors.black54,
                                  size: 20,
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 14),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : SizedBox(
                      height: 10,
                    ),
              searchBar(
                searchController: newChatController,
                onTap: () {
                  if (newChatController.text.isNotEmpty && !_isAITyping) {
                    sendMessage(newChatController.text);
                    newChatController.clear();
                  }
                },
                chat: true,
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ],
    );
  }
}
