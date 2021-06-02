import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/panel/presentation/bloc/panel_bloc.dart';
import 'package:showroom/features/panel/presentation/widgets/variants.dart';

class PanelCore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PanelBloc, PanelState>(
        buildWhen: (previous, current) =>
            previous.selectedVariant != current.selectedVariant,
        builder: (context, state) {
          return Column(
            children: [
              ExtendedImage.asset(
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
                      Variants(
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
                      ExtendedImage.asset(
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
