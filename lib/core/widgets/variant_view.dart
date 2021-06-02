import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';

import '../../features/products/presentation/widgets/circular_indicator.dart';

class VariantView extends StatelessWidget {
  final List<Variant>? variants;
  final Variant? currentVariant;
  final void Function(Variant variant) onTap;

  const VariantView({
    required this.variants,
    required this.currentVariant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (variants?.length ?? 0) > 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: variants?.map((variant) {
              return Padding(
                padding:
                    EdgeInsets.only(right: DinamicSize.widthSize(context, 40)),
                child: InkWell(
                  onTap: () => onTap(variant),
                  child: Column(
                    children: [
                      Visibility(
                        visible: variant.name == currentVariant?.name,
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFB42E2D),
                                width: 5,
                              ),
                            ),
                            height: DinamicSize.heightSize(context, 60),
                            width: DinamicSize.widthSize(context, 60),
                            child: ExtendedImage.asset(
                              "assets/" + (variant.img ?? "notfound.jpeg"),
                              fit: BoxFit.cover,
                            )),
                        replacement: SizedBox(
                            height: DinamicSize.heightSize(context, 60),
                            width: DinamicSize.widthSize(context, 60),
                            child: ExtendedImage.asset(
                              "assets/" + (variant.img ?? "notfound.jpeg"),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Text(
                        (variant.name?.toUpperCase() ?? ""),
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0.24,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList() ??
            [],
      ),
      replacement: CircularIndicator(),
    );
  }
}
