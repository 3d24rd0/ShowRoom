import 'package:draw_your_image/draw_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/features/multiTouch/presentation/bloc/multitouch_bloc.dart';
import 'package:showroom/features/multiTouch/presentation/widgets/variant_selector.dart';

import '../../../../service_locator.dart';
import 'collections.dart';
import 'list_of_product_selected.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MultitouchBloc>(
      create: (_) => getIt<MultitouchBloc>()..add(LoadEvent()),
      child: BlocBuilder<MultitouchBloc, MultitouchState>(
          buildWhen: (previous, current) =>
              previous.runtimeType != current.runtimeType,
          builder: (context, state) {
            return Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 3,
                  child: Collections(),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 12,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: VariantSelector(),
                      ),
                      Expanded(
                        flex: 3,
                        child: Draw(
                            // controller: _controller,
                            backgroundColor: Color(0xFF76899C),
                            strokeColor: Colors.red,
                            strokeWidth: 8,
                            isErasing: false,
                            onConvertImage: (imageData) {
                              // do something with imageData
                            }),
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: ListOfProductSelected(),
                )
              ],
            );
          }),
    );
  }
}
