import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/core/widgets/custom_image.dart';
import 'package:showroom/features/products/presentation/bloc/product_bloc.dart';
import 'package:showroom/core/widgets/variant_view.dart';
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
                    child: CustomImage(
                      path: "assets/" +
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
                        VariantView(
                          variants: state?.selectedProduct?.variants,
                          currentVariant: state?.selectedVariant,
                          onTap: (variant) =>
                              variant.name != state?.selectedVariant?.name
                                  ? BlocProvider.of<ProductBloc>(context)
                                      .add(SetCurrentProductVariant(variant))
                                  : null,
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

  const _TitleDivider({required this.esp, this.eng});

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
