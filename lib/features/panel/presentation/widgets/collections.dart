import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/panel/presentation/bloc/panel_bloc.dart';

import 'collection_title.dart';

class Collections extends StatelessWidget {
  final bool left;

  const Collections({
    Key? key,
    required this.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 80.w(context), bottom: 60.w(context)),
      // width: 326.w(context),
      color: Color(0xff3C3E3F),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CollectionTitle(left: left),
          BlocBuilder<PanelBloc, PanelState>(
              buildWhen: (previous, current) =>
                  previous.selectedVariant != current.selectedVariant,
              builder: (context, state) {
                final collection = (left
                        ? state.collectionPanel?.leftCollection
                        : state.collectionPanel?.rightCollection) ??
                    List.empty();
                final selectedProduct = state.selectedProduct;
                final selectedVariant = state.selectedVariant;

                return Container(
                  padding: EdgeInsets.only(top: 30.h(context)),
                  height: 700.h(context),
                  child: Scrollbar(
                    child: ListView.builder(
                        itemCount: collection.length,
                        itemBuilder: (BuildContext ctx, index) {
                          String name = collection[index].name ?? "";
                          String variantName =
                              collection[index].variantName ?? "";
                          return InkWell(
                            onTap: () => BlocProvider.of<PanelBloc>(context)
                                .add(SelectEvent(collection[index])),
                            child: Row(
                              mainAxisAlignment: left
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              children: [
                                Visibility(
                                  visible: left &&
                                      name.toUpperCase() ==
                                          selectedProduct?.name
                                              ?.toUpperCase() &&
                                      variantName.toUpperCase() ==
                                          selectedVariant?.name?.toUpperCase(),
                                  child: Icon(
                                    Icons.arrow_left,
                                    color: Color(0xff6CF149),
                                    size: 50.w(context),
                                  ),
                                  replacement: Container(
                                    width: 50.w(context),
                                    height: 50.w(context),
                                  ),
                                ),
                                Text(
                                  name[0].toUpperCase() +
                                      name.substring(1).toLowerCase() +
                                      " " +
                                      variantName[0].toUpperCase() +
                                      variantName.substring(1).toLowerCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign:
                                      left ? TextAlign.left : TextAlign.right,
                                  style: TextStyle(
                                    color: name.toUpperCase() ==
                                                selectedProduct?.name
                                                    ?.toUpperCase() &&
                                            variantName.toUpperCase() ==
                                                selectedVariant?.name
                                                    ?.toUpperCase()
                                        ? Color(0xff6CF149)
                                        : Color(0xffA0A1A2),
                                    fontSize: DinamicSize.fontSize(context, 20),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.2,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                Visibility(
                                  visible: !left &&
                                      name.toUpperCase() ==
                                          selectedProduct?.name
                                              ?.toUpperCase() &&
                                      variantName.toUpperCase() ==
                                          selectedVariant?.name?.toUpperCase(),
                                  child: Icon(
                                    Icons.arrow_right,
                                    size: 50.w(context),
                                    color: Color(0xff6CF149),
                                  ),
                                  replacement: Container(
                                    width: 50.w(context),
                                    height: 50.w(context),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

