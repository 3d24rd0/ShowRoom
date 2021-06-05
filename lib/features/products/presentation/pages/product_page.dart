import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/products/presentation/bloc/product_bloc.dart';
import 'package:showroom/features/products/presentation/widgets/body.dart';
import 'package:showroom/core/widgets/circular_indicator.dart';
import 'package:showroom/service_locator.dart';

class ProductPage extends StatelessWidget {
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
              child: BlocProvider<ProductBloc>(
                create: (_) => getIt<ProductBloc>()..add(LoadEvent()),
                child: BlocListener<ProductBloc, ProductState>(
                  listenWhen: (previous, current) =>
                      previous.message != current.message &&
                      (current.message?.isNotEmpty ?? false),
                  listener: (context, state) {
                    var message = state.message ?? "";

                    // Scaffold.of(context).showSnackBar(SnackBar(
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        onVisible: () => Future.delayed(Duration(seconds: 3)),
                        backgroundColor: Color(0xff18469f),
                        content: SizedBox(
                          height: DinamicSize.heightSize(context, 50),
                          child: Center(
                            child: Container(
                              child: Text(
                                message,
                                style: TextStyle(
                                  color: Color(0xfffaf900),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 0.24,
                                ),
                              ),
                            ),
                          ),
                        )));
                  },
                  child: BlocBuilder<ProductBloc, ProductState>(
                    buildWhen: (previous, current) =>
                        previous.runtimeType != current.runtimeType,
                    builder: (context, state) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Body(),
                          Visibility(
                            visible: state.runtimeType != InitializedState,
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
