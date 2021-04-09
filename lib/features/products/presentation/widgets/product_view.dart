import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';
import 'package:showroom/features/products/presentation/bloc/product_bloc.dart';

import 'circular_indicator.dart';
import 'variant_sizes.dart';

class ProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) =>
            previous.selectedProduct != current.selectedProduct ||
            previous.selectedVariant != current.selectedVariant,
        builder: (context, ProductState? state) {
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
                    child: Image.asset(
                      "assets/" +
                          (state?.selectedVariant?.img ?? "notfound.jpeg"),
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
                        _TitleDivider(
                          esp: "medidas",
                          eng: "sizes",
                        ),
                        VariantSizes(variant: state?.selectedVariant),
                      ],
                    ),
                    Column(
                      children: [
                        _TitleDivider(
                          esp: "colores",
                          eng: "colors",
                        ),
                        _Variants(
                          variants: state?.selectedProduct?.variants,
                          currentVariant: state?.selectedVariant,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

class _TitleDivider extends StatelessWidget {
  final String esp;
  final String? eng;

  const _TitleDivider({required this.esp, this.eng})
     ;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              esp + ((eng?.isNotEmpty ?? false) ? " / " : ""),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                letterSpacing: 0.24,
              ),
            ),
            Visibility(
              visible: (eng?.isNotEmpty ?? false),
              child: Text(
                eng ?? " ",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.24,
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              top: DinamicSize.heightSize(context, 8),
              bottom: DinamicSize.heightSize(context, 8)),
          child: Container(
            color: Color(0xFF000000),
            height: DinamicSize.heightSize(context, 1),
          ),
        ),
      ],
    );
  }
}

class _Variants extends StatelessWidget {
  final List<Variant>? variants;
  final Variant? currentVariant;

  const _Variants({required this.variants, required this.currentVariant});
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
                  onTap: () => variant.name != currentVariant?.name
                      ? BlocProvider.of<ProductBloc>(context)
                          .add(SetCurrentProductVariant(variant))
                      : null,
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
                            child: Image.asset(
                              "assets/" + (variant.img ?? "notfound.jpeg"),
                              fit: BoxFit.cover,
                            )),
                        replacement: SizedBox(
                            height: DinamicSize.heightSize(context, 60),
                            width: DinamicSize.widthSize(context, 60),
                            child: Image.asset(
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
