import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markdown/markdown.dart' as md;

class aiMessage extends StatelessWidget {
  const aiMessage({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          child: CircleAvatar(
              radius: 15,
              child: SvgPicture.asset(
                'assets/openai_black.svg',
                width: 20,
              )),
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              right: 45,
              top: 5,
              bottom: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Markdown(
              physics: const NeverScrollableScrollPhysics(),
              selectable: true,
              styleSheet:
                  MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                p: const TextStyle(fontSize: 15),
                code: const TextStyle(
                    color: Colors.white, backgroundColor: Colors.black45),
                codeblockDecoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              extensionSet: md.ExtensionSet(
                md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                [
                  md.EmojiSyntax(),
                  md.CodeSyntax(),
                  md.ColorSwatchSyntax(),
                  ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                ],
              ),
              data: text,
              shrinkWrap: true,
            ),
          ),
        ),
      ],
    );
  }
}
