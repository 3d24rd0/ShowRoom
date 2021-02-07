import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showroom/features/main/presentation/pages/main_page.dart';
import 'package:showroom/simple_bloc_observer.dart';

import 'features/main/presentation/widgets/circular_indicator.dart';
import 'service_locator.dart';

main() async {
  runApp(Container(
    color: Colors.blue,
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
      // navigatorKey: getIt<RouterBloc>().navigatorKey,
      // initialRoute: CustomRouter.login,
      // onGenerateRoute: (settings) => CustomRouter.generateRoute(settings),
      home: MainPage(),
    );
  }

  @override
  void initState() {
    super.initState();
    // Remove `loading` div
    // final loader = document.getElementsByClassName('loading');
    // if (loader.isNotEmpty) {
    //   loader.first.remove();
    // }
  }

  @override
  void dispose() {
    // Hive.close();
    super.dispose();
  }
}
