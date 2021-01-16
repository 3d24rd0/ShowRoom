import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/img_string.dart';
import 'package:showroom/features/main/presentation/bloc/main_bloc.dart';

import 'circular_indicator.dart';

class ListProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
        buildWhen: (previous, current) =>
            previous.products != current?.products,
        builder: (context, state) {
          final length = state?.products?.length ?? 0;
          return Scrollbar(
            child: Visibility(
              visible: length > 0,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var product = state?.products[index];

                  return Card(
                    child: ListTile(
                      onTap: () => BlocProvider.of<MainBloc>(context)
                          .add(SetCurrentProduct(product)),
                      leading: ImgString(
                        defaultImgPath: 'assets/notfound.jpeg',
                        img: product?.variants?.first?.img,
                      ),
                      title: Text(product.name),
                      subtitle: Text(
                        product.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // trailing: Icon(Icons.more_vert),
                      isThreeLine: true,
                    ),
                  );
                },
                itemCount: length,
              ),
              replacement: CircularIndicator(),
            ),
          );
        });
  }
}
