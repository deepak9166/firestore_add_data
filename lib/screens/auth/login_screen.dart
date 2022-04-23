import 'package:applore_assignment/util/app_string.dart';
import 'package:flutter/material.dart';

import '../../components/custom_textfield.dart';
import '../../util/constant.dart';
import '../../util/route_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final _textStyle = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Login",
              style: _textStyle.headline3,
            ),
            const CustomTextField(
              hintText: AppString.enterEmail,
            ),
            const CustomTextField(
              hintText: AppString.enterPassword,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteGenrator.dashboard, (route) => false);
                },
                child: const Text("Login"))
          ],
        ),
      )),
    );
  }
}
