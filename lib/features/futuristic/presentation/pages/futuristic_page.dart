import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/core/widgets/custom_image.dart';
import 'package:showroom/core/widgets/title_divider.dart';
import 'package:showroom/core/widgets/variant_sizes.dart';
import 'package:showroom/core/widgets/variant_view.dart';
import 'package:showroom/features/futuristic/presentation/bloc/futuristic_bloc.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';

import '../../../../service_locator.dart';

class FuturisticPage extends StatelessWidget {
  final bloc = getIt<FuturisticBloc>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false); // if true allow back else block it
      },
      child: Scaffold(
        backgroundColor: Color(0xff3C3E3F),
        body: BlocProvider(
          create: (context) => bloc..add(LoadEvent()),
          child: BlocBuilder<FuturisticBloc, FuturisticState>(
            builder: (context, state) {
              return Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: state.materiales?.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            bloc
                              ..add(SelectMaterialEvent(
                                  state.materiales?[index].products));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Center(
                                  child: Text(
                                      state.materiales?[index].name ?? "")),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color(0xffA0A1A2),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Flexible(
                    flex: 9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                var size = state.selectedProducsId?.length ?? 0;
                                var numRows = (size / 6).ceil();
                                return Wrap(
                                  alignment: WrapAlignment.center,
                                  children: List.generate(size, (index) {
                                    var product = state.products?.firstWhere(
                                        (element) =>
                                            element.id ==
                                            state.selectedProducsId![index]);
                                    return SizedBox(
                                      height:
                                          constraints.biggest.height / numRows,
                                      width: size >= 6
                                          ? constraints.biggest.width / 6.01
                                          : constraints.biggest.width / size,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            bloc.add(
                                                SelectProductEvent(product));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: CustomImage(
                                                  path: "assets/" +
                                                      (product?.variants?.first
                                                              .img ??
                                                          "notfound.jpeg"),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                product?.name?.toUpperCase() ??
                                                    "",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Color(0xffA0A1A2),
                                                  fontSize:
                                                      DinamicSize.fontSize(
                                                          context, 32),
                                                  fontWeight: FontWeight.w300,
                                                  letterSpacing: 0.2,
                                                  fontFamily: 'Montserrat',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Color(0xffA0A1A2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: DinamicSize.heightSize(
                                            context, 30)),
                                    child: SizedBox(
                                      height:
                                          DinamicSize.heightSize(context, 550),
                                      width:
                                          DinamicSize.widthSize(context, 550),
                                      child: AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child:
                                            state.variants?.isNotEmpty == true
                                                ? CustomImage(
                                                    path: "assets/" +
                                                        (state.variants?.first
                                                                .example ??
                                                            "notfound.jpeg"),
                                                    fit: BoxFit.cover,
                                                  )
                                                : Container(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: DinamicSize.widthSize(context, 750),
                                    // height: DinamicSize.heightSize(context, 500),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            children: [
                                              TitleDivider(
                                                esp: "medidas",
                                                eng: "sizes",
                                              ),
                                              Flexible(
                                                child: state.variants
                                                            ?.isNotEmpty ==
                                                        true
                                                    ? VariantSizes(
                                                        variant: state.variants
                                                                ?.first ??
                                                            Variant(),
                                                      )
                                                    : Container(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              TitleDivider(
                                                esp: "colores",
                                                eng: "colors",
                                              ),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: VariantView(
                                                      variants: state.variants,
                                                      currentVariant: null,
                                                      onTap: (variant) => null,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
