import 'package:flutter/material.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/core/widgets/custom_image.dart';
import 'package:showroom/features/products/domain/entities/measure.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';

class VariantSizes extends StatelessWidget {
  final Variant variant;

  const VariantSizes({required this.variant});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: variant.thickness?.length ?? 0,
      itemBuilder: (context, index) {
        var thickness = variant.thickness?[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: thickness?.measures?.map((measure) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _image(measure, context),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                (measure.height?.toString() ?? "") +
                                    "x" +
                                    (measure.width?.toString() ?? ""),
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 0.24,
                                ),
                              ),
                            )
                          ],
                        );
                      }).toList() ??
                      [],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  thickness?.name ?? "",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.24,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );

  }

  Visibility _image(Measure? measure, BuildContext context) {
    return Visibility(
      visible: (measure?.img?.isNotEmpty ?? false),
      child: SizedBox(
        height:
            DinamicSize.heightSize(context, (measure?.height?.toInt() ?? 0)),
        width: DinamicSize.widthSize(context, (measure?.width?.toInt() ?? 0)),
        child: CustomImage(
          path: "assets/" + (measure?.img ?? "notfound.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      replacement: Container(
        height:
            DinamicSize.heightSize(context, (measure?.height?.toInt() ?? 0)),
        width: DinamicSize.widthSize(context, (measure?.width?.toInt() ?? 0)),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      ),
    );
  }
}
