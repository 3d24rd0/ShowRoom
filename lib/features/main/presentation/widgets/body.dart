import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/main/presentation/bloc/main_bloc.dart';

import 'product/product_list.dart';
import 'product/product_view.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Header(),
        Expanded(
          child: Container(
            color: Color(0xffF2F2F2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: DinamicSize.widthSize(context, 389),
                  child: ProductList(),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: DinamicSize.heightSize(context, 60),
                          left: DinamicSize.widthSize(context, 60)),
                      child: ProductView(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffCCCCCC),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Color(0xffC2C2C2),
            height: DinamicSize.heightSize(context, 181),
            width: DinamicSize.widthSize(context, 389),
            child: Center(
              child: Text(
                "Collections".toUpperCase(),
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.24,
                ),
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(right: 80),
              height: DinamicSize.heightSize(context, 181),
              width: DinamicSize.widthSize(context, 1400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BlocBuilder<MainBloc, MainState>(
                      buildWhen: (previous, current) =>
                          previous?.selectedProduct != current?.selectedProduct,
                      builder: (context, state) {
                        return Text(
                          (state?.selectedProduct?.name ?? "").toUpperCase(),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 70,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0.24,
                          ),
                        );
                      }),
                  Text(
                    "colección ‧ collection".toUpperCase(),
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 0.24,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
