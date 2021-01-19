import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/main/domain/entities/measure.dart';
import 'package:showroom/features/main/domain/entities/variant.dart';
import 'package:showroom/features/main/presentation/bloc/main_bloc.dart';

import '../circular_indicator.dart';

class ProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
        buildWhen: (previous, current) =>
            previous.selectedProduct != current?.selectedProduct ||
            previous.selectedVariant != current.selectedVariant,
        builder: (context, state) {
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
                        _VariantSizes(variant: state?.selectedVariant),
                      ],
                    ),
                    Column(
                      children: [
                        _TitleDivider(
                          esp: "colores",
                          eng: "colors",
                        ),
                        _Variants(variants: state?.selectedProduct?.variants)
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

class _VariantSizes extends StatelessWidget {
  final Variant variant;

  const _VariantSizes({Key key, @required this.variant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (variant?.measures?.length ?? 0) > 0,
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final measure = variant.measures[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _image(measure, context),
                Padding(
                  padding:
                      EdgeInsets.only(left: DinamicSize.widthSize(context, 20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: measure?.description?.isNotEmpty ?? false,
                        child: Text(
                          measure?.description,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0.24,
                          ),
                        ),
                      ),
                      Text(
                        measure.width.toString() +
                            "x" +
                            measure.height.toString() +
                            " cm",
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0.24,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: DinamicSize.heightSize(context, 11),
                      left: DinamicSize.widthSize(context, 8),
                      right: DinamicSize.widthSize(context, 8),
                    ),
                    // width: DinamicSize.widthSize(context, 350),
                    height: 1,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "REF. " + measure.ref?.toUpperCase(),
                  style: TextStyle(
                    color: Color(0xFFB42E2D),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.24,
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: (variant?.measures?.length ?? 0),
      ),
      replacement: CircularIndicator(),
    );
  }

  Visibility _image(Measure measure, BuildContext context) {
    return Visibility(
      visible: (measure?.img?.isNotEmpty ?? false),
      child: SizedBox(
        height: DinamicSize.heightSize(context, measure.height.toInt()),
        width: DinamicSize.widthSize(context, measure.width.toInt()),
        child: Image.asset(
          "assets/" + (measure?.img ?? "notfound.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      replacement: Container(
        height: DinamicSize.heightSize(context, measure.height.toInt()),
        width: DinamicSize.widthSize(context, measure.width.toInt()),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      ),
    );
  }
}

class _TitleDivider extends StatelessWidget {
  final String esp;
  final String eng;

  const _TitleDivider({Key key, @required this.esp, this.eng})
      : super(key: key);

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
                eng,
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
  final List<Variant> variants;

  const _Variants({Key key, @required this.variants}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (variants?.length ?? 0) > 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: variants?.map((e) {
              return Padding(
                padding:
                    EdgeInsets.only(right: DinamicSize.widthSize(context, 40)),
                child: Column(
                  children: [
                    SizedBox(
                        height: DinamicSize.heightSize(context, 60),
                        width: DinamicSize.widthSize(context, 60),
                        child: Image.asset(
                          "assets/" + (e?.img ?? "notfound.jpeg"),
                          fit: BoxFit.cover,
                        )),
                    Text(
                      e.name.toUpperCase(),
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
              );
            })?.toList() ??
            [],
      ),
      replacement: CircularIndicator(),
    );
  }
}
