import 'package:flutter/material.dart';

import '../util/constant.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  const CustomTextField(
      {Key? key, this.hintText = "", this.textEditingController, this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: appPadding/2),
      child: TextField(
        controller: textEditingController,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 2),
          ),
        ),
      ),
    );
  }
}
