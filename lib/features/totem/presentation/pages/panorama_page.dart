import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showroom/features/products/presentation/pages/product_page.dart';

class PanoramaPage extends StatefulWidget {
  PanoramaPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  createState() => _PanoramaPage();
}

class _PanoramaPage extends State<PanoramaPage> {
  bool showProductInfo = false;
  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;
  int _panoId = 0;
  List<Image> panoImages = [
    Image.asset('assets/pp.jpg'),
    Image.asset('assets/panorama2.webp'),
    Image.asset('assets/panorama_cropped.webp'),
  ];
  ImagePicker picker = ImagePicker();

  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude;
      _lat = latitude;
      _tilt = tilt;
    });
  }

  Widget hotspotButton({
    String? text,
    IconData? icon,
  }) {
    return Expanded(
      child: InkWell(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget panorama;
    switch (_panoId % panoImages.length) {
      case 0:
        panorama = Panorama(
          animSpeed: 1.0,
          sensorControl: SensorControl.None,
          onViewChanged: onViewChanged,
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
              latitude: -15.0,
              longitude: -129.0,
              width: 90,
              height: 75,
              widget: hotspotButton(
                text: "Next scene",
                icon: Icons.open_in_browser,
              ),
            ),
            Hotspot(
              latitude: -42.0,
              longitude: -46.0,
              width: 60.0,
              height: 60.0,
              widget: hotspotButton(
                icon: Icons.search,
              ),
            ),
            Hotspot(
              latitude: -33.0,
              longitude: 123.0,
              width: 60.0,
              height: 60.0,
              widget: hotspotButton(
                icon: Icons.arrow_upward,
              ),
            ),
            Hotspot(
              latitude: -17,
              longitude: 0,
              width: 1060.0,
              height: 360.0,
              name: "sdfads",
              widget: hotspotButton(
                icon: Icons.arrow_upward,
              ),
            ),
          ],
        );
        break;
      case 2:
        panorama = Panorama(
          animSpeed: 1.0,
          sensorControl: SensorControl.None,
          onViewChanged: onViewChanged,
          croppedArea: Rect.fromLTWH(2533.0, 1265.0, 5065.0, 2533.0),
          croppedFullWidth: 10132.0,
          croppedFullHeight: 5066.0,
          child: Image.asset('assets/panorama_cropped.jpg'),
          hotspots: [
            Hotspot(
              latitude: 0.0,
              longitude: -46.0,
              width: 90.0,
              height: 75.0,
              widget: hotspotButton(
                text: "Next scene",
                icon: Icons.double_arrow,
              ),
            ),
          ],
        );
        break;
      default:
        panorama = Panorama(
          animSpeed: 1.0,
          sensorControl: SensorControl.None,
          onViewChanged: onViewChanged,
          child: panoImages[_panoId % panoImages.length],
          hotspots: [
            Hotspot(
              latitude: 0.0,
              longitude: 160.0,
              width: 90.0,
              height: 75.0,
              widget: hotspotButton(
                text: "Next scene",
                icon: Icons.double_arrow,
              ),
            ),
          ],
        );
    }

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
            Text(
              '${_lon.toStringAsFixed(3)}, ${_lat.toStringAsFixed(3)}, ${_tilt.toStringAsFixed(3)}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
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
