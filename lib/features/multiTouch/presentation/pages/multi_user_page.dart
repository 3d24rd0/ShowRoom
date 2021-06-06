import 'package:flutter/material.dart';
import 'package:showroom/features/multiTouch/presentation/widgets/body.dart';

class MultiUserPage extends StatefulWidget {
  @override
  State<MultiUserPage> createState() => _MultiUserPageState();
}

class _MultiUserPageState extends State<MultiUserPage> {
  int numbUsers = 1;
  final Body user1 = Body();
  final Body user2 = Body();
  final Body user3 = Body();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false); // if true allow back else block it
      },
      child: Scaffold(
        backgroundColor: Color(0xffA0A1A2),
        body: SafeArea(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 700),
            child: _buildBody(),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Visibility(
              visible: numbUsers != 1,
              child: SizedBox(
                height: 30,
                width: 30,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      numbUsers = 1;
                    });
                  },
                  child: ClipOval(
                    child: Container(
                      color: Colors.white,
                      child: Center(child: Text("1")),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: numbUsers != 2,
              child: SizedBox(
                height: 30,
                width: 30,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      numbUsers = 2;
                    });
                  },
                  child: ClipOval(
                    child: Container(
                      color: Colors.white,
                      child: Center(child: Text("2")),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: numbUsers != 3,
              child: SizedBox(
                height: 30,
                width: 30,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      numbUsers = 3;
                    });
                  },
                  child: ClipOval(
                    child: Container(
                      color: Colors.white,
                      child: Center(child: Text("3")),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBody() {
    switch (numbUsers) {
      case 2:
        return _twoUsers();
      case 3:
        return _threeUsers();
      default:
        return user1;
    }
  }

  _twoUsers() {
    return Column(
      children: [
        Expanded(
          child: RotatedBox(quarterTurns: 2, child: user2),
        ),
        Container(
          height: 20,
          color: Colors.black,
        ),
        Expanded(
          child: user1,
        ),
      ],
    );
  }

  _threeUsers() {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: RotatedBox(quarterTurns: 1, child: user3),
        ),
        Container(
          width: 20,
          color: Colors.black,
        ),
        Flexible(
          flex: 2,
          child: Column(
            children: [
              Expanded(
                child: RotatedBox(quarterTurns: 2, child: user2),
              ),
              Container(
                height: 20,
                color: Colors.black,
              ),
              Expanded(
                child: user1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
