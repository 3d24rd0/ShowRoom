import 'package:flutter/material.dart';
import 'package:showroom/features/hall/presentation/pages/hall_page.dart';
import 'package:showroom/features/multiTouch/presentation/pages/multi_touch_page.dart';
import 'package:showroom/features/panel/presentation/pages/panel_page.dart';
import 'package:showroom/features/products/presentation/pages/product_page.dart';
import 'package:showroom/features/totem/presentation/pages/panorama_page.dart';

class CustomRouter {
  static const hall = "/";
  static const products = "/products";
  static const totem = "/totem";
  static const panel = "/panel";
  static const multitouch = "/multitouch";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CustomRouter.hall:
        return MaterialPageRoute(builder: (_) => HallPage());

      case CustomRouter.products:
        return MaterialPageRoute(builder: (_) => ProductPage());

      case CustomRouter.totem:
        return MaterialPageRoute(
          builder: (_) => PanoramaPage(
            title: '',
            // serieId: settings.arguments,
          ),
          settings: settings,
        );

      case CustomRouter.panel:
        return MaterialPageRoute(
          builder: (_) => PanelPage(
            panelId: settings.arguments.toString(),
          ),
        );
      case CustomRouter.multitouch:
        return MaterialPageRoute(
          builder: (_) => MultiTouchPage(),
        );
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute(
      {required WidgetBuilder builder, required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // if (settings.isInitialRoute)
    //   return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}
