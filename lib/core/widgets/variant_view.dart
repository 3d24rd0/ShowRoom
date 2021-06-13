import 'package:flutter/material.dart';
import 'package:showroom/core/widgets/variant_box.dart';
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
      child: Wrap(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        direction: Axis.horizontal,
        children: variants?.map((variant) {
              return VariantBox(
                onTap: onTap,
                currentVariant: currentVariant,
                variant: variant,
              );
            }).toList() ??
            [],
      ),
      replacement: CircularIndicator(),
    );
  }
}
