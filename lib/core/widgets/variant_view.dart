import 'package:flutter/material.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';

import 'circular_indicator.dart';
import 'custom_image.dart';

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: variants?.map((variant) {
              return Padding(
                padding: const EdgeInsets.only(right: 30),
                child: InkWell(
                  onTap: () => onTap(variant),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          child: CustomImage(
                            path: "assets/" + (variant.img ?? "notfound.jpeg"),
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        replacement: SizedBox(
                          child: CustomImage(
                            path: "assets/" + (variant.img ?? "notfound.jpeg"),
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                        ),
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
