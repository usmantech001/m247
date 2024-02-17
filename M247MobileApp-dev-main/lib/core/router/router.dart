import 'package:flutter/material.dart';
import 'package:masjid/data/models/masjid_model.dart';
import 'package:masjid/presentation/screens/home/home.dart';
import 'package:masjid/presentation/screens/jummah/jummah.dart';
import 'package:masjid/presentation/screens/masjid/masjid.dart';

class RouteGenerator {
  static const String home = "/home";
  static const String masjid = '/masjid';
  static const String jummah = '/jummah';

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _routeBuilder(const Home());
      case jummah:
      final pageController = settings.arguments as PageController;
        return _routeBuilder( Jummah(pageController: pageController,));
      case masjid:
      
        final data = settings.arguments as Map<String, dynamic>;
        //final pageController = settings.arguments as PageController;
        return _routeBuilder(Masjid(masjid: data['masjidmodel'], pageController:data['pagecontroller']));
      default:
        return _routeBuilder(const Home());
    }
  }

  static void goNamed(String route) {
    navigatorKey.currentState!.pushNamed(route);
  }

  static PageRouteBuilder _routeBuilder(Widget page) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (_, animation, __, child) {
          const begin = 0.0;
          const end = 1.0;
          const curve = Curves.easeInOut;

          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          final fadeAnimation = animation.drive(tween);

          return FadeTransition(opacity: fadeAnimation, child: child);
        });
  }
}
