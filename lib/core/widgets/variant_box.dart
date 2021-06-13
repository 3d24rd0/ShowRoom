import 'package:flutter/material.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';

import 'custom_image.dart';

class VariantBox extends StatelessWidget {
  const VariantBox({
    Key? key,
    required this.onTap,
    required this.currentVariant,
    required this.variant,
  }) : super(key: key);

  final void Function(Variant variant) onTap;
  final Variant? currentVariant;
  final Variant variant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
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
                    color: Color(0xff6CF149),
                    width: 2,
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
                  height: 52,
                  width: 52,
                ),
              ),
            ),
            SizedBox(
              width: 50,
              child: Text(
                (variant.name?.toUpperCase() ?? ""),
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.24,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            )
          ],
        ),
      ),
    );
  }
}
