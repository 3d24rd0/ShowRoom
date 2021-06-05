import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/core/widgets/collection_title.dart';
import 'package:showroom/features/multiTouch/presentation/bloc/multitouch_bloc.dart';
import 'package:showroom/core/widgets/circular_indicator.dart';

class Collections extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 80.w(context), ),
      color: Color(0xff3C3E3F),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CollectionTitle(),
          BlocBuilder<MultitouchBloc, MultitouchState>(
              buildWhen: (previous, current) =>
                  previous.product != current.product,
              builder: (context, state) {
                return Visibility(
                  visible: state.products.length > 0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var product = state.products[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () =>
                                BlocProvider.of<MultitouchBloc>(context)
                                    .add(SetCurrentProduct(product)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  (product.name?.toUpperCase() ?? ""),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color(0xffA0A1A2),
                                    fontSize: 40,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 0.24,
                                  ),
                                ),
                                Visibility(
                                  visible: product.name == state.product.name,
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_right,
                                      color: Color(0xFFB42E2D),
                                      size: DinamicSize.heightSize(context, 40),
                                    ),
                                  ),
                                  replacement: SizedBox(
                                    width: DinamicSize.heightSize(context, 40),
                                  ),
                                )
                              ],
                            )),
                      );
                    },
                    itemCount: state.products.length,
                  ),
                  replacement: CircularIndicator(),
                );
              }),
        ],
      ),
    );
  }
}
