import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/panel/domain/entities/collection.dart';
import 'package:showroom/features/panel/presentation/bloc/panel_bloc.dart';
import 'package:showroom/features/panel/presentation/widgets/collections.dart';
import 'package:showroom/features/products/domain/entities/product.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';
import 'package:showroom/features/products/presentation/widgets/circular_indicator.dart';
import 'package:showroom/service_locator.dart';

class PanelPage extends StatelessWidget {
  final String panelId;

  const PanelPage({Key? key, required this.panelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false); // if true allow back else block it
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocProvider<PanelBloc>(
            create: (_) => getIt<PanelBloc>()..add(LoadEvent(panelId)),
            child: BlocBuilder<PanelBloc, PanelState>(
              buildWhen: (previous, current) =>
                  previous.runtimeType != current.runtimeType,
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        Collections(
                          left: false,
                        ),
                        Expanded(child: _PanelCore()),
                        Collections(
                          left: true,
                        ),
                      ],
                    ),
                    Visibility(
                      visible: state.runtimeType != InitializedState,
                      child: Positioned.fill(
                        child: Container(
                          color: Color(0xFF3F3C3C),
                          child: Center(
                            child: CircularIndicator(),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PanelCore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PanelBloc, PanelState>(
        buildWhen: (previous, current) =>
            previous.selectedVariant != current.selectedVariant,
        builder: (context, state) {
          return Column(
            children: [
              Image.asset(
                "assets/" + (state.selectedVariant?.example ?? "notfound.jpeg"),
                fit: BoxFit.cover,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Colors".toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: DinamicSize.fontSize(context, 20),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Container(
                        width: 300,
                        child: Divider(
                          thickness: 1,
                          color: Color(0xffA0A1A2),
                        ),
                      ),
                      _Variants(
                        currentVariant: state.selectedVariant,
                        product: state.selectedProduct,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Sizes".toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: DinamicSize.fontSize(context, 20),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Container(
                        width: 300,
                        child: Divider(
                          thickness: 1,
                          color: Color(0xffA0A1A2),
                        ),
                      ),
                      Image.asset(
                        "assets/test.png",
                        fit: BoxFit.contain,
                        height: 250.h(context),
                        width: 800.w(context),
                      ),
                    ],
                  )
                ],
              ),
            ],
          );
        });
  }
}

class _Variants extends StatelessWidget {
  final Variant? currentVariant;
  final Product? product;

  const _Variants({required this.currentVariant, required this.product});

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
                            child: Image.asset(
                              "assets/" + (variant.img ?? "notfound.jpeg"),
                              fit: BoxFit.fill,
                            )),
                        replacement: SizedBox(
                            child: Image.asset(
                          "assets/" + (variant.img ?? "notfound.jpeg"),
                          fit: BoxFit.fill,
                        )),
                      ),
                    )),
                Text(
                  (variant.name?.toUpperCase() ?? ""),
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 14.f(context),
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.24,
                  ),
                )
              ],
            );
          }),
    );
  }
}
