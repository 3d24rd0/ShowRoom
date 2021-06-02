import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/products/domain/entities/measure.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';

import 'circular_indicator.dart';

class VariantSizes extends StatelessWidget {
  final Variant? variant;

  const VariantSizes({@required this.variant});
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (variant?.measures?.length ?? 0) > 0,
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final measure = variant?.measures![index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _image(measure, context),
                Padding(
                  padding:
                      EdgeInsets.only(left: DinamicSize.widthSize(context, 20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: measure?.description?.isNotEmpty ?? false,
                        child: Text(
                          measure?.description ?? "",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0.24,
                          ),
                        ),
                      ),
                      Text(
                        (measure?.width.toString() ?? "") +
                            "x" +
                            (measure?.height.toString() ?? "") +
                            " cm",
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0.24,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: DinamicSize.heightSize(context, 11),
                      left: DinamicSize.widthSize(context, 8),
                      right: DinamicSize.widthSize(context, 8),
                    ),
                    // width: DinamicSize.widthSize(context, 350),
                    height: 1,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "REF. " + (measure?.ref?.toUpperCase() ?? ""),
                  style: TextStyle(
                    color: Color(0xFFB42E2D),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.24,
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: (variant?.measures?.length ?? 0),
      ),
      replacement: CircularIndicator(),
    );
  }

  Visibility _image(Measure? measure, BuildContext context) {
    return Visibility(
      visible: (measure?.img?.isNotEmpty ?? false),
      child: SizedBox(
        height: DinamicSize.heightSize(context, (measure?.height.toInt() ?? 0)),
        width: DinamicSize.widthSize(context, (measure?.width.toInt() ?? 0)),
        child: ExtendedImage.asset(
          "assets/" + (measure?.img ?? "notfound.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      replacement: Container(
        height: DinamicSize.heightSize(context, (measure?.height.toInt() ?? 0)),
        width: DinamicSize.widthSize(context, (measure?.width.toInt() ?? 0)),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      ),
    );
  }
}
