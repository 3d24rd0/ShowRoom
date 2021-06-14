import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/core/widgets/custom_image.dart';
import 'package:showroom/core/widgets/title_divider.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';
import 'package:showroom/features/products/presentation/bloc/product_bloc.dart';
import 'package:showroom/core/widgets/variant_view.dart';
import '../../../../core/widgets/variant_sizes.dart';

class ProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) =>
            previous.selectedProduct != current.selectedProduct ||
            previous.selectedVariant != current.selectedVariant,
        builder: (context, ProductState state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: DinamicSize.heightSize(context, 30)),
                child: SizedBox(
                  height: DinamicSize.heightSize(context, 550),
                  width: DinamicSize.widthSize(context, 550),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: CustomImage(
                      path: "assets/" +
                          (state.selectedVariant?.example ?? "notfound.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: DinamicSize.widthSize(context, 750),
                // height: DinamicSize.heightSize(context, 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        TitleDivider(
                          esp: "medidas",
                          eng: "sizes",
                        ),
                        VariantSizes(
                            variant: state.selectedVariant ?? Variant()),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TitleDivider(
                            esp: "colores",
                            eng: "colors",
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: VariantView(
                                  variants: state.selectedProduct?.variants,
                                  currentVariant: state.selectedVariant,
                                  onTap: (variant) => variant.name !=
                                          state.selectedVariant?.name
                                      ? BlocProvider.of<ProductBloc>(context)
                                          .add(
                                              SetCurrentProductVariant(variant))
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
