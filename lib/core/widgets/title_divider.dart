import 'package:flutter/material.dart';

class TitleDivider extends StatelessWidget {
  final String esp;
  final String? eng;

  const TitleDivider({required this.esp, this.eng});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              esp + ((eng?.isNotEmpty ?? false) ? " / " : ""),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                letterSpacing: 0.24,
              ),
            ),
            Visibility(
              visible: (eng?.isNotEmpty ?? false),
              child: Text(
                eng ?? " ",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.24,
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Container(
            color: Color(0xFF000000),
            height: 1,
          ),
        ),
      ],
    );
  }
}
