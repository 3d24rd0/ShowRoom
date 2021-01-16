import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImgString extends StatefulWidget {
  final String img;
  final String defaultImgPath;

  const ImgString({Key key, @required this.img, @required this.defaultImgPath})
      : super(key: key);
  @override
  _ImgStringState createState() => _ImgStringState();
}

class _ImgStringState extends State<ImgString> {
  Image img;
  String imgpath;
  @override
  void initState() {
    imgpath = widget.img;
    initializeImg();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ImgString oldWidget) {
    if (imgpath != widget.img) {
      imgpath = widget.img;
      initializeImg();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return img;
  }

  initializeImg() {
    try {
      final Uint8List bytes = !(imgpath == null || imgpath.isEmpty)
          ? Base64Decoder().convert(imgpath)
          : null;
      if (bytes != null) {
        img = Image.memory(
          bytes,
          fit: BoxFit.fitHeight,
        );
      } else {
        img = Image.asset(
          widget.defaultImgPath,
          fit: BoxFit.cover,
        );
      }
    } catch (e) {
      log("cant load img", name: "_ImgStringState");
      img = Image.asset(
        widget.defaultImgPath,
        fit: BoxFit.cover,
      );
    }
  }
}
