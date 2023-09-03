import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgpt/data/constants.dart';
import 'package:sgpt/widgets/frosted_glass.dart';

// ignore: camel_case_types
class searchBar extends StatefulWidget {
  final TextEditingController searchController;
  final VoidCallback onTap;
  final bool chat;

  const searchBar(
      {Key? key,
      required this.onTap,
      required this.searchController,
      required this.chat})
      : super(key: key);

  @override
  State<searchBar> createState() => _searchBarState();
}

// ignore: camel_case_types
class _searchBarState extends State<searchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: FrostedGlass(
        child: Container(
          height: 55,
          padding: const EdgeInsets.only(left: 15, right: 5),
          decoration: BoxDecoration(
              border: Border.all(
                color: itextColor == Colors.black && widget.chat
                    ? Colors.black87
                    : iwhite70,
                width: 2.5,
              ),
              color:
                  itextColor == Colors.black ? Colors.white12 : Colors.black12,
              borderRadius: BorderRadius.circular(21)),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    HapticFeedback.heavyImpact();
                    if (widget.searchController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: 'Write something to search',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: iwhite0_6,
                          textColor: Colors.black,
                          fontSize: 16.0);
                    } else {
                      widget.onTap();
                    }
                  },
                  cursorColor: itextColor == Colors.black && widget.chat
                      ? Colors.black
                      : iwhite70,
                  style: TextStyle(
                    fontSize: 20,
                    color: itextColor == Colors.black && widget.chat
                        ? Colors.black
                        : Colors.white,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: "Ask anything to AI",
                    hintStyle: TextStyle(
                        color: itextColor == Colors.black && widget.chat
                            ? Colors.black54
                            : Colors.white60),
                  ),
                  controller: widget.searchController,
                ),
              ),
              InkWell(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  if (widget.searchController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Write something to search',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: iwhite0_6,
                        textColor: Colors.black,
                        fontSize: 16.0);
                  } else {
                    widget.onTap();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: itextColor == Colors.black && widget.chat
                        ? Colors.black.withOpacity(0.8)
                        : Colors.white.withOpacity(0.8),
                  ),
                  width: 38,
                  height: 38,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      itextColor == Colors.black && widget.chat
                          ? 'assets/logo.svg'
                          : 'assets/openai_black.svg',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
