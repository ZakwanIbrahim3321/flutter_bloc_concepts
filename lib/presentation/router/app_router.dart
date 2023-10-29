import 'package:bloc_concept/presentation/screens/home_screen.dart';
import 'package:bloc_concept/presentation/screens/second_screen.dart';
import 'package:bloc_concept/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(
            title: 'Home Screen',
            color: Colors.blueAccent,
          ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => const SecondScreen(
            title: 'Second Screen',
            color: Colors.redAccent,
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => const ThirdScreen(
            title: 'Third Screen',
            color: Colors.green,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }


}
