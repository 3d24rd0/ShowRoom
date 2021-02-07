import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/products/presentation/bloc/product_bloc.dart';

import 'circular_indicator.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) =>
            previous.products != current?.products ||
            previous.selectedProduct != current?.selectedProduct,
        builder: (context, state) {
          final length = state?.products?.length ?? 0;
          return Visibility(
            visible: length > 0,
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var product = state?.products[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () => BlocProvider.of<ProductBloc>(context)
                          .add(SetCurrentProduct(product)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            product.name.toUpperCase(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: product == state.selectedProduct
                                  ? Color(0xFFB42E2D)
                                  : Color(0xFF000000),
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0.24,
                            ),
                          ),
                          Visibility(
                            visible: product == state.selectedProduct,
                            child: Center(
                              child: Icon(
                                Icons.arrow_right,
                                color: Color(0xFFB42E2D),
                                size: DinamicSize.heightSize(context, 40),
                              ),
                            ),
                            replacement: SizedBox(
                              width: DinamicSize.heightSize(context, 40),
                            ),
                          )
                        ],
                      )),
                );
              },
              itemCount: length,
            ),
            replacement: CircularIndicator(),
          );
        });
  }
}
