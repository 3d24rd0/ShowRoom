import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/main/presentation/bloc/main_bloc.dart';

import '../circular_indicator.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
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
                  child: FlatButton(
                      onPressed: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            product.name.toUpperCase(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: product == state.selectedProduct
                                  ? Color(0xFFB42E2D)
                                  : Color(0xFF000000),
                              fontSize: 26,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0.24,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: DinamicSize.heightSize(context, 8),
                                bottom: DinamicSize.heightSize(context, 8)),
                            child: Container(
                              color: product == state.selectedProduct
                                  ? Color(0xFFB42E2D)
                                  : Color(0xFF000000),
                              height: DinamicSize.heightSize(context,
                                  product == state.selectedProduct ? 4 : 1),
                            ),
                          ),
                          // Text(
                          //   product.name,
                          //   textAlign: TextAlign.right,
                          //   style: TextStyle(
                          //     color: Color(0xFF000000),
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.w400,
                          //     fontStyle: FontStyle.normal,
                          //     letterSpacing: 0.24,
                          //   ),
                          // ),
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
