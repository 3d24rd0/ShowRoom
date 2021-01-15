import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:showroom/features/main/presentation/pages/main_page.dart';
import 'package:showroom/simple_bloc_observer.dart';

import 'service_locator.dart';

main() async {
  await setUpLocator();
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  // final FileSystem fs = MemoryFileSystem();
  // final Directory home = fs.directory("/Users/eduardo");
  // // final Directory tmp = await fs.systemTempDirectory.createTemp('example_');
  // final File outputFile = home.childFile('output');
  // await outputFile.writeAsString('Hello world!');
  // print(outputFile.readAsStringSync());
  // print(outputFile.uri);

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
    Hive.close();
    super.dispose();
  }
}
