import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).accentColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
