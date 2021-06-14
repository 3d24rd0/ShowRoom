import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/panel/domain/entities/collection.dart';
import 'package:showroom/features/panel/presentation/bloc/panel_bloc.dart';

import '../../../../core/widgets/collection_title.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';
import 'package:showroom/features/products/domain/entities/product.dart';

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
          CollectionTitle(),
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

                return Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: collection.length,
                        itemBuilder: (BuildContext ctx, index) {
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
                                      collection[index].productId ==
                                          selectedProduct?.id &&
                                      collection[index]
                                              .variantId
                                              ?.toLowerCase() ==
                                          selectedVariant?.id?.toLowerCase(),
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
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: left
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.end,
                                      children: [
                                        Visibility(
                                          visible: left,
                                          child: _text(
                                              (index + 1).toString() + " ",
                                              collection,
                                              index,
                                              selectedProduct,
                                              selectedVariant,
                                              context),
                                        ),
                                        Flexible(
                                          child: _text(
                                              getProductTitle(
                                                collection[index].name ?? "",
                                              ),
                                              collection,
                                              index,
                                              selectedProduct,
                                              selectedVariant,
                                              context),
                                        ),
                                        Visibility(
                                          visible: !left,
                                          child: _text(
                                              " " + (index + 1).toString(),
                                              collection,
                                              index,
                                              selectedProduct,
                                              selectedVariant,
                                              context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: !left &&
                                      collection[index].productId ==
                                          selectedProduct?.id &&
                                      collection[index]
                                              .variantId
                                              ?.toUpperCase() ==
                                          selectedVariant?.id?.toUpperCase(),
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

  Text _text(
    String text,
    List<Collection> collection,
    int index,
    Product? selectedProduct,
    Variant? selectedVariant,
    BuildContext context,
  ) {
    return Text(
      text,
      maxLines: collection[index].maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: left ? TextAlign.left : TextAlign.right,
      style: TextStyle(
        color: collection[index].productId == selectedProduct?.id &&
                collection[index].variantId?.toUpperCase() ==
                    selectedVariant?.id?.toUpperCase()
            ? Color(0xff6CF149)
            : Color(0xffA0A1A2),
        fontSize: DinamicSize.fontSize(context, 20),
        fontWeight: FontWeight.bold,
        letterSpacing: 0.2,
        height: 1.3,
        fontFamily: 'Montserrat',
      ),
    );
  }

  String getProductTitle(String name) {
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }
}
