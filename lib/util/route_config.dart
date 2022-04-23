import 'package:applore_assignment/screens/auth/login_screen.dart';
import 'package:applore_assignment/screens/home/add_product.dart';
import 'package:flutter/material.dart';

import '../screens/home/dashboard.dart';
import 'app_string.dart';

class RouteGenrator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case addProduct:
        return MaterialPageRoute(builder: (_) => const AddProduct());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text(AppString.pageNotFound),
        ),
      );
    });
  }

  static const String dashboard = "dashboard";
  static const String addProduct = "addProduct";
}
