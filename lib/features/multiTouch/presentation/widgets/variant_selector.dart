import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/widgets/custom_image.dart';
import 'package:showroom/core/widgets/variant_view.dart';
import 'package:showroom/features/multiTouch/presentation/bloc/multitouch_bloc.dart';

class VariantSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultitouchBloc, MultitouchState>(
        builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: CustomImage(
              path: "assets/" + (state.variant.example ?? "notfound.jpeg"),
              fit: BoxFit.contain,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 9,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: VariantView(
                      variants: state.product.variants,
                      currentVariant: state.variant,
                      onTap: (variant) => variant.name != state.variant.name
                          ? BlocProvider.of<MultitouchBloc>(context)
                              .add(SetCurrentProductVariantEvent(variant))
                          : null,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff3C3E3F),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      )),
                  child: TextButton(
                    onPressed: () => BlocProvider.of<MultitouchBloc>(context)
                        .add(AddCollectionVariantEvent()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_business_outlined,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Añadir",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xffA0A1A2),
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.2,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
