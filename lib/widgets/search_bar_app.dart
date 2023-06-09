import 'package:flutter/material.dart';
import 'package:sgpt/data/constants.dart';

// ignore: camel_case_types
class appSearchBar extends StatefulWidget {
  final TextEditingController searchController;
  final VoidCallback onTap;

  const appSearchBar({Key? key, required this.onTap, required this.searchController})
      : super(key: key);

  @override
  State<appSearchBar> createState() => _appSearchBarState();
}

// ignore: camel_case_types
class _appSearchBarState extends State<appSearchBar> {
  bool showIconSearch = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 13),
      padding: const EdgeInsets.only(left: 15, right: 5),
      decoration: BoxDecoration(
          border: Border.all(color: iwhite70, width: 3),
          color: Colors.black12,
          borderRadius: BorderRadius.circular(19)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              cursorColor: iwhite70,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                widget.onTap();
              },
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    showIconSearch = false;
                  });
                } else {
                  setState(() {
                    showIconSearch = true;
                  });
                }
              },
              minLines: 1,
              style: const TextStyle(fontSize: 20, color: Colors.white),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Apps',
                hintStyle: TextStyle(color: Colors.white60),
              ),
              controller: widget.searchController,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                widget.searchController.clear();
                widget.onTap();
                showIconSearch = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: iwhite0_6),
              width: 38,
              height: 38,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: showIconSearch
                    ? const Icon(Icons.close, color: Colors.black)
                    : const Icon(Icons.search, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
