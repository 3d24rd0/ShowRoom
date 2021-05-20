import 'package:flutter/material.dart';
import 'package:showroom/core/tools/dinamic_size.dart';

class CollectionTitle extends StatelessWidget {
  const CollectionTitle({
    Key? key,
    required this.left,
  }) : super(key: key);

  final bool left;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260.w(context),
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
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
    );
  }
}
