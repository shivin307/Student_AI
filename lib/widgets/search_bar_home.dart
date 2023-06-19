import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgpt/data/constants.dart';
import 'package:sgpt/widgets/frosted_glass.dart';

class searchBar extends StatefulWidget {
  final TextEditingController searchController;
  final VoidCallback onTap;
  final bool chat;

  searchBar(
      {Key? key,
      required this.onTap,
      required this.searchController,
      required this.chat})
      : super(key: key);

  @override
  State<searchBar> createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13),
      child: FrostedGlass(
        child: Container(
          height: 55,
          padding: EdgeInsets.only(left: 15, right: 5),
          decoration: BoxDecoration(
              border: Border.all(
                  color: widget.chat ? Colors.black87 : iwhite70, width: 3),
              color: Colors.black12,
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
                          backgroundColor: iwhite,
                          textColor: Colors.black,
                          fontSize: 16.0);
                    } else {
                      widget.onTap();
                    }
                  },
                  cursorColor: widget.chat ? Colors.black : iwhite70,
                  style: TextStyle(
                    fontSize: 20,
                    color: widget.chat ? Colors.black : Colors.white,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: "Ask anything to AI",
                    hintStyle: TextStyle(
                        color: widget.chat ? Colors.black54 : Colors.white60),
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
                        backgroundColor: iwhite,
                        textColor: Colors.black,
                        fontSize: 16.0);
                  } else {
                    widget.onTap();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: widget.chat
                        ? Colors.black.withOpacity(0.8)
                        : Colors.white.withOpacity(0.8),
                  ),
                  width: 38,
                  height: 38,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      widget.chat
                          ? 'assets/openai_white.svg'
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