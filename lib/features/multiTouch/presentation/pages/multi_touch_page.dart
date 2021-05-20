import 'package:draw_your_image/draw_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/core/widgets/variant_view.dart';
import 'package:showroom/features/multiTouch/presentation/bloc/multitouch_bloc.dart';
import 'package:showroom/features/multiTouch/presentation/widgets/collections.dart';
import 'package:showroom/service_locator.dart';

class MultiTouchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false); // if true allow back else block it
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: BlocProvider<MultitouchBloc>(
            create: (_) => getIt<MultitouchBloc>()..add(LoadEvent()),
            child: BlocListener<MultitouchBloc, MultitouchState>(
              listener: (context, state) {
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     onVisible: () => Future.delayed(Duration(seconds: 3)),
                //     backgroundColor: Color(0xff18469f),
                //     content: SizedBox(
                //       height: DinamicSize.heightSize(context, 50),
                //       child: Center(
                //         child: Container(
                //           child: Text(
                //             "message",
                //             style: TextStyle(
                //               color: Color(0xfffaf900),
                //               fontSize: 18,
                //               fontWeight: FontWeight.w400,
                //               fontStyle: FontStyle.normal,
                //               letterSpacing: 0.24,
                //             ),
                //           ),
                //         ),
                //       ),
                //     )));
              },
              child: BlocBuilder<MultitouchBloc, MultitouchState>(
                  buildWhen: (previous, current) =>
                      previous.runtimeType != current.runtimeType,
                  builder: (context, state) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 300.h(context),
                          child: Collections(),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              _VariantSelector(),
                              Expanded(
                                child: Draw(
                                    // controller: _controller,
                                    backgroundColor: Color(0xFF76899C),
                                    strokeColor: Colors.red,
                                    strokeWidth: 8.h(context),
                                    isErasing: false,
                                    onConvertImage: (imageData) {
                                      // do something with imageData
                                    }),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 350.h(context),
                          child: _ListOfProductSelected(),
                        )
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

class _ListOfProductSelected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 50.w(context),
      ),
      color: Color(0xff3C3E3F),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 260.w(context),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Color(0xffA0A1A2),
                width: 8.h(context),
              )),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "User Name".toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xffA0A1A2),
                    fontSize: DinamicSize.fontSize(context, 32),
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.2,
                    fontFamily: 'Montserrat',
                  ),
                ),
                IconButton(
                  onPressed: () => BlocProvider.of<MultitouchBloc>(context)
                      .add(SalirEvent()),
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<MultitouchBloc, MultitouchState>(
              builder: (context, state) {
            return Expanded(
                // height: MediaQuery.of(context).size.height - 200.h(context),
                child: ListView.builder(
                  itemCount: state.collections.length,
                  itemBuilder: (context, index) {
                    var collection = state.collections[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          (collection.name ?? "") +
                              " " +
                              (collection.variantName ?? ""),
                          style: TextStyle(
                            color: Color(0xffA0A1A2),
                            fontSize: DinamicSize.fontSize(context, 32),
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.2,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              
            );
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50.h(context),
              decoration: BoxDecoration(
                  color: Color(0xffA0A1A2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  )),
              child: TextButton(
                onPressed: () =>
                    BlocProvider.of<MultitouchBloc>(context).add(EnviarEvent()),
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
                      "Enviar",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: DinamicSize.fontSize(context, 32),
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.2,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _VariantSelector extends StatelessWidget {
  const _VariantSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultitouchBloc, MultitouchState>(
        builder: (context, state) {
      return Column(
        children: [
          Image.asset(
            "assets/" + (state.variant.example ?? "notfound.jpeg"),
            fit: BoxFit.cover,
          ),
          Container(
            color: Color(0xffA0A1A2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                              fontSize: DinamicSize.fontSize(context, 32),
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.2,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
