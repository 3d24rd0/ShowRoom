import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/main/presentation/bloc/main_bloc.dart';
import 'package:showroom/features/main/presentation/widgets/circular_indicator.dart';
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
                  final length = 1; // state?.products?.length ?? 0;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: DinamicSize.heightSize(context, 550),
                            width: DinamicSize.heightSize(context, 550),
                            child: Scrollbar(
                              child: Visibility(
                                visible: length > 0,
                                child: ListView.builder(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    //var product = state.products[index];
                                    return Card(
                                      child: ListTile(
                                        leading: FlutterLogo(size: 72.0),
                                        title: Text('Tile'),
                                        subtitle: Text(
                                            'A bbasdas  asdad adad adadaa d.'),
                                        trailing: Icon(Icons.more_vert),
                                        isThreeLine: true,
                                      ),
                                    );
                                  },
                                  itemCount: length,
                                ),
                                replacement: CircularIndicator(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      Visibility(
                        visible: state?.runtimeType != InitializedState,
                        child: Expanded(
                            child: Container(
                                color: Colors.blue,
                                child: Center(child: CircularIndicator()))),
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
