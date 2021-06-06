import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class PanoramaPage extends StatefulWidget {
  PanoramaPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  createState() => _PanoramaPage();
}

class _PanoramaPage extends State<PanoramaPage> {
  bool showProductInfo = false;

  Widget hotspotButton({
    String? text,
    IconData? icon,
  }) {
    return InkWell(
        onTap: () {
          setState(() {
            showProductInfo = true;
          });
        },
        child: ClipOval(
          child: Container(
            color: Color(0x9C983232),
          ),
        ),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    var panorama = Panorama(
      animSpeed: 0.3,
      sensorControl: SensorControl.None,
      // onViewChanged: (longitude, latitude, tilt) {
      //   print(
      //     '${longitude.toStringAsFixed(3)}, ${latitude.toStringAsFixed(3)}, ${tilt.toStringAsFixed(3)}',
      //   );
      // },
      onTap: (longitude, latitude, tilt) =>
          print('onTap: $longitude, $latitude, $tilt'),
      onLongPressStart: (longitude, latitude, tilt) =>
          print('onLongPressStart: $longitude, $latitude, $tilt'),
      onLongPressMoveUpdate: (longitude, latitude, tilt) =>
          print('onLongPressMoveUpdate: $longitude, $latitude, $tilt'),
      onLongPressEnd: (longitude, latitude, tilt) =>
          print('onLongPressEnd: $longitude, $latitude, $tilt'),
      child: Image.asset('assets/pp.jpg'),
      hotspots: [
        Hotspot(
          latitude: -17,
          longitude: 0,
          width: 1060.0,
          height: 360.0,
          widget: hotspotButton(
            icon: Icons.arrow_upward,
          ),
        ),
      ],
    );

    return WillPopScope(
      onWillPop: () {
        return Future.value(false); // if true allow back else block it
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: Stack(
          children: [
            panorama,
            Visibility(
              visible: showProductInfo,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        showProductInfo = false;
                      });
                    },
                    child: Container(
                      color: Color(0x7D000000),
                    ),
                  )),
                  Center(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Container(color: Colors.white)),
                  ),
                ],
              ),
            )
            // Center(
            //   child: SizedBox(
            //     height: 1,
            //     width: 1,
            //     child: ClipOval(
            //       child: Container(
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
