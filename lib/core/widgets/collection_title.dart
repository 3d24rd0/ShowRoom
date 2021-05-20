import 'package:flutter/material.dart';
import 'package:showroom/core/tools/dinamic_size.dart';

class CollectionTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        width: 260.w(context),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Color(0xffA0A1A2),
            width: 8.h(context),
          )),
        ),
        alignment: Alignment.center,
        child: Text(
          "Collections".toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color(0xffA0A1A2),
            fontSize: DinamicSize.fontSize(context, 32),
            fontWeight: FontWeight.w300,
            letterSpacing: 0.2,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
