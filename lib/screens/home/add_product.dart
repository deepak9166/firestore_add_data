import 'dart:io';

import 'package:applore_assignment/components/custom_textfield.dart';
import 'package:applore_assignment/firebase/firebase_handler.dart';
import 'package:applore_assignment/util/app_string.dart';
import 'package:applore_assignment/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/get_image.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String imagePath = "";
  bool isLoader = false;
  String sizeInfo = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: ListView(children: [
          CustomTextField(
            hintText: AppString.enterProductName,
            textEditingController: _nameController,
          ),
          CustomTextField(
            hintText: AppString.description,
            textEditingController: _descController,
          ),
          CustomTextField(
            hintText: AppString.price,
            textEditingController: _priceController,
            keyboardType: TextInputType.number,
          ),
          imagePath.isNotEmpty
              ? Image.file(
                  File(imagePath),
                  height: 200,
                )
              : const SizedBox(),
          IconButton(
              onPressed: () {
                getImage(ImageSource.gallery).then((orignalFile) async {
                  if (orignalFile != null) {

                    var fileSize = getFileSizeString(
                        bytes: (await orignalFile.readAsBytes()).lengthInBytes);
                    print("origanal $fileSize");

                    compressImage(orignalFile).then((newFile) async {
                      imagePath = newFile.path;
                      var fileSizecompressImage = getFileSizeString(
                          bytes: (await newFile.readAsBytes()).lengthInBytes);
                      print("compressImage $fileSizecompressImage");

                      sizeInfo = "Original file size : $fileSize and compress size : $fileSizecompressImage";
                      setState(() {

                      });

                    });

                  }
                });
              },
              icon: const Icon(
                Icons.add_a_photo,
                color: Colors.black,
              )),

          Text(sizeInfo, style: TextStyle(fontSize: 22, color: Colors.green), textAlign: TextAlign.center,),
          TextButton(
              onPressed: () async {
                if (_nameController.text.isNotEmpty &&
                    _descController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty &&
                    !isLoader) {
                  Map<String, dynamic> body = {
                    "productName": _nameController.text.trim(),
                    "desc": _descController.text.trim(),
                    "price": _priceController.text.trim(),
                  };
                  FocusScope.of(context).unfocus();
                  isLoader = true;
                  setState(() {});
                  await FirebaseHandler.addProduct(
                          body,
                          DateTime.now().millisecondsSinceEpoch.toString(),
                          File(imagePath))
                      .catchError((e) {
                    /// Todo : handle error on add product
                  });
                  isLoader = false;
                  setState(() {});

                  Navigator.pop(context);
                } else {
                  /// Todo : handle validation here
                }
              },
              child: isLoader
                  ? const CircularProgressIndicator()
                  : const Text("Submit")),
        ]),
      ),
    );
  }
}
