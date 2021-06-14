import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/features/panel/presentation/bloc/panel_bloc.dart';
import 'package:showroom/features/panel/presentation/widgets/collections.dart';
import 'package:showroom/features/panel/presentation/widgets/panel_core.dart';
import 'package:showroom/core/widgets/circular_indicator.dart';
import 'package:showroom/service_locator.dart';

class PanelPage extends StatelessWidget {
  final String panelId;

  const PanelPage({Key? key, required this.panelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false); // if true allow back else block it
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocProvider<PanelBloc>(
            create: (_) => getIt<PanelBloc>()..add(LoadEvent(panelId)),
            child: BlocBuilder<PanelBloc, PanelState>(
              buildWhen: (previous, current) =>
                  previous.runtimeType != current.runtimeType,
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Collections(
                            left: false,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: PanelCore(),
                        ),
                        Flexible(
                          flex: 2,
                          child: Collections(
                            left: true,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: state.runtimeType != InitializedState,
                      child: Positioned.fill(
                        child: Container(
                          color: Color(0xFF3F3C3C),
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
    );
  }
}
