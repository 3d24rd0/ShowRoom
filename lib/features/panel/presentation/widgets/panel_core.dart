import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/widgets/custom_image.dart';
import 'package:showroom/core/widgets/title_divider.dart';
import 'package:showroom/core/widgets/variant_sizes.dart';
import 'package:showroom/core/widgets/variant_view.dart';
import 'package:showroom/features/panel/domain/entities/collection.dart';
import 'package:showroom/features/panel/presentation/bloc/panel_bloc.dart';

class PanelCore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PanelBloc, PanelState>(
        buildWhen: (previous, current) =>
            previous.selectedVariant != current.selectedVariant,
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomImage(
                path: "assets/" +
                    (state.selectedVariant?.example ?? "notfound.jpeg"),
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 3,
              ),
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: _colorsColumn(state, context),
                      ),
                    ),
                    Flexible(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: _sizesColumn(state),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  _colorsColumn(PanelState state, BuildContext context) {
    return Column(
      children: [
        TitleDivider(
          esp: "colores",
          eng: "colors",
        ),
        Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: VariantView(
                variants: state.selectedProduct?.variants,
                currentVariant: state.selectedVariant,
                onTap: (variant) => variant.name != state.selectedVariant?.name
                    ? BlocProvider.of<PanelBloc>(context).add(
                        SelectEvent(
                          Collection(
                            name: state.selectedProduct?.name,
                            variantId: variant.id,
                            maxLines: 1,
                            productId: state.selectedProduct?.id,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _sizesColumn(PanelState state) {
    return Column(
      children: [
        TitleDivider(
          esp: "medidas",
          eng: "sizes",
        ),
        // VariantSizes(variant: state.selectedVariant)
        Flexible(
          child: SingleChildScrollView(
            child: VariantSizes(variant: state.selectedVariant),
          ),
        ),
      ],
    );
  }
}
