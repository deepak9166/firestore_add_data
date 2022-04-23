/// Applre Technologies - Assignment
/// Start by Deepak Kachchhawah
/// 23/06/2022 : 1:40 PM

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/theme.dart';
import 'screens/auth/login_screen.dart';
import 'services/product_provider.dart';
import 'util/route_config.dart';

final Future<FirebaseApp> initialization = Firebase.initializeApp();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialization.then((value) {
    print("**************** firebase initialization *************");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ProductProvider(),),

    ], child: MaterialApp(
      title: 'Product App',
      theme: AppTheme.darkTheme,
      initialRoute: "/",
      onGenerateRoute: RouteGenrator.generateRoute,
      home: const LoginScreen(),
    ),);
  }
}
