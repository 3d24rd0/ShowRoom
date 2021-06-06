import 'package:flutter/material.dart';
import 'package:showroom/features/multiTouch/presentation/widgets/body.dart';

class OneUSerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false); // if true allow back else block it
      },
      child: Scaffold(
        backgroundColor: Color(0xffA0A1A2),
        body: SafeArea(
          child: Body(),
        ),
      ),
    );
  }
}
