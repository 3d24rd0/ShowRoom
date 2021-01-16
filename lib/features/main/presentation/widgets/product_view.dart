import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/core/tools/img_string.dart';
import 'package:showroom/features/main/presentation/bloc/main_bloc.dart';

class ProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
        buildWhen: (previous, current) =>
            previous.selectedProduct != current?.selectedProduct ||
            previous.selectedVariant != current.selectedVariant,
        builder: (context, state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      state?.selectedProduct?.name ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff18469f),
                        fontSize: DinamicSize.fontSize(context, 40),
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: DinamicSize.heightSize(context, 200),
                    width: DinamicSize.widthSize(context, 200),
                    child: ImgString(
                      defaultImgPath: 'assets/notfound.jpeg',
                      img: state?.selectedVariant?.img,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              Text(
                state?.selectedProduct?.description ?? "",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xff18469f),
                  fontSize: DinamicSize.fontSize(context, 20),
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              Row(
                children: (state?.selectedProduct?.variants ?? List.empty())
                    .map(
                      (e) => SizedBox(
                        height: DinamicSize.heightSize(context, 90),
                        width: DinamicSize.widthSize(context, 90),
                        child: InkWell(
                          onTap: () => BlocProvider.of<MainBloc>(context)
                              .add(SetCurrentProductVariant(e)),
                          child: ImgString(
                            defaultImgPath: 'assets/notfound.jpeg',
                            img: e?.img,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          );
        });
  }
}
