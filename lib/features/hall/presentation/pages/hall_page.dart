import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/features/hall/domain/entities/machine.dart';
import 'package:showroom/features/hall/domain/entities/machine_type.dart';
import 'package:showroom/features/hall/presentation/bloc/hall_bloc.dart';
import 'package:showroom/service_locator.dart';

class HallPage extends StatelessWidget {
  final List<Machine> machines = [
    Machine(id: '0', type: MachineType.products, name: "Products"),
    Machine(id: '1', type: MachineType.panels, name: "Pasillo 1"),
    Machine(id: '2', type: MachineType.panels, name: "Pasillo 2"),
    Machine(id: '3', type: MachineType.totem, name: "Entrada"),
  ];

  void onTab(int index, BuildContext context) {
    switch (machines[index].type) {
      case MachineType.panels:
        BlocProvider.of<HallBloc>(context)
            .add(NavigateToPanelEvent(machines[index].id));
        break;
      case MachineType.totem:
        BlocProvider.of<HallBloc>(context)
            .add(NavigateToTotemEvent(machines[index].id));
        break;
      case MachineType.products:
        BlocProvider.of<HallBloc>(context).add(NavigateToProductsEvent());
        break;
      default:
    }
  }

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
          // backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Color(0xff606263),
            title: Text("Select Machine"),
          ),
          body: SafeArea(
            child: ExcludeSemantics(
              excluding: true,
              child: BlocProvider<HallBloc>(
                  create: (_) => getIt<HallBloc>(),
                  child: BlocBuilder<HallBloc, HallState>(
                    builder: (context, state) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xff606263), Color(0xFF3E404E)],
                          ),
                        ),
                        child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2 / 3,
                              crossAxisSpacing: 7,
                              mainAxisSpacing: 7,
                            ),
                            itemCount: machines.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      onTab(index, context);
                                    },
                                    child: Card(
                                      elevation: 18.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Container(
                                          color: Colors.black87,
                                          child: iconImage(index)),
                                      clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.all(8.0),
                                    ),
                                  ),
                                  Text(
                                    machines[index].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    ),
                                  )
                                ],
                              );
                            }),
                      );
                    },
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget iconImage(int index) {
    switch (machines[index].type) {
      case MachineType.panels:
        return Image.asset(
          "assets/panels.png",
          fit: BoxFit.scaleDown,
          height: 170.0,
          width: 130.0,
        );
      case MachineType.totem:
        return Image.asset(
          "assets/totem.png",
          fit: BoxFit.scaleDown,
          height: 170.0,
          width: 130.0,
        );
      default:
        return Container(
          color: Colors.white,
          height: 170.0,
          width: 130.0,
        );
    }
  }
}
