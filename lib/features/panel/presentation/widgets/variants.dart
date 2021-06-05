import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/panel/domain/entities/collection.dart';
import 'package:showroom/features/panel/presentation/bloc/panel_bloc.dart';
import 'package:showroom/features/products/domain/entities/product.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';

class Variants extends StatelessWidget {
  final Variant? currentVariant;
  final Product? product;

  const Variants({required this.currentVariant, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 250,
      child: GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3 / 3,
            mainAxisSpacing: 7,
            crossAxisSpacing: 7,
          ),
          itemCount: product?.variants?.length ?? 0,
          itemBuilder: (BuildContext ctx, index) {
            Variant variant = product?.variants?[index] ??
                Variant(img: null, example: null, name: null, measures: null);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () => BlocProvider.of<PanelBloc>(context).add(
                          SelectEvent(
                            Collection(
                              name: product?.name,
                              variantName: variant.name,
                              maxLines: 1,
                              productId: product?.id,
                            ),
                          ),
                        ),
                    child: SizedBox(
                      height: 90.w(context),
                      width: 90.w(context),
                      child: Visibility(
                        visible: variant.name == currentVariant?.name,
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff6CF149),
                                width: 3,
                              ),
                            ),
                            child: ExtendedImage.asset(
                              "assets/" + (variant.img ?? "notfound.jpeg"),
                              fit: BoxFit.fill,
                            )),
                        replacement: SizedBox(
                            child: ExtendedImage.asset(
                          "assets/" + (variant.img ?? "notfound.jpeg"),
                          fit: BoxFit.fill,
                        )),
                      ),
                    )),
                // Text(
                //   (variant.name?.toUpperCase() ?? ""),
                //   style: TextStyle(
                //     color: Color(0xFF000000),
                //     fontSize: 14.f(context),
                //     fontWeight: FontWeight.w300,
                //     fontStyle: FontStyle.normal,
                //     letterSpacing: 0.24,
                //   ),
                // )
              ],
            );
          }),
    );
  }
}
