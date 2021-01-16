import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/main/presentation/bloc/main_bloc.dart';
import 'package:showroom/features/main/presentation/widgets/circular_indicator.dart';
import 'package:showroom/features/main/presentation/widgets/list_products.dart';
import 'package:showroom/features/main/presentation/widgets/product_view.dart';
import 'package:showroom/service_locator.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false); // if true allow back else block it
      },
      child: Semantics(
        container: true,
        label: "Bienvenido",
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
              child: ExcludeSemantics(
            excluding: true,
            child: BlocProvider<MainBloc>(
              create: (_) => getIt<MainBloc>()..add(LoadEvent()),
              child: BlocBuilder<MainBloc, MainState>(
                buildWhen: (previous, current) =>
                    previous?.runtimeType != current?.runtimeType,
                builder: (context, state) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            // height: DinamicSize.heightSize(context, 550),
                            width: DinamicSize.heightSize(context, 550),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListProducts(),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: ProductView(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Visibility(
                        visible: state?.runtimeType != InitializedState,
                        child: Positioned.fill(
                          child: Container(
                            color: Colors.blue,
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
          )),
        ),
      ),
    );
  }
}
