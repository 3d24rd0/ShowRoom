import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/simple_bloc_observer.dart';
import 'core/route/bloc/router_bloc.dart';
import 'core/route/custom_router.dart';
import 'core/widgets/circular_indicator.dart';
import 'service_locator.dart';

main() async {
  runApp(Container(
    color: Color(0xFF3F3C3C),
    child: Center(
      child: CircularIndicator(),
    ),
  ));

  await setUpLocator();
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShowRoom',
      // theme: myTheme,
      navigatorKey: getIt<RouterBloc>().navigatorKey,
      initialRoute: CustomRouter.hall,
      // onGenerateInitialRoutes: (initialRoute) {
      //   return [
      //     MaterialPageRoute(
      //       builder: (_) => PanelPage(
      //         panelId: "1",
      //       ),
      //     )
      //   ];
      // },
      onGenerateRoute: (settings) => CustomRouter.generateRoute(settings),
      // home: ProductPage(),
    );
  }
}
