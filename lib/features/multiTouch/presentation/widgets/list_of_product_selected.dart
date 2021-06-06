import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/core/tools/dinamic_size.dart';
import 'package:showroom/features/multiTouch/presentation/bloc/multitouch_bloc.dart';

class ListOfProductSelected extends StatelessWidget {
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
                            (collection.variantId ?? ""),
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
