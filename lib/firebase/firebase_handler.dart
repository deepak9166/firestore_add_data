import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseHandler {
  static const String productCollection = "productCollection";
  static var  firestore =  FirebaseFirestore.instance;
  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchProduct() {
    return FirebaseFirestore.instance.collection(productCollection).snapshots();
  }


  static Future <QuerySnapshot<Object?>>  fetchFirstTimeData(DocumentSnapshot lastDoc, int dataLimit) async {
    return await firestore
        .collection(FirebaseHandler.productCollection)
        .orderBy('productName')
        .startAfterDocument(lastDoc)
        .limit(dataLimit)
        .get();
  }
  static Future addProduct(
      Map<String, dynamic> body, String id, File file) async {
    print("start upload in firebase");
    var link = await uploadFile(file);
    body.putIfAbsent("image", () => link);
    await FirebaseFirestore.instance
        .collection(productCollection)
        .doc(id)
        .set(body);
  }

  static Future uploadFile(File file) async {
    final fileName = basename(file.path);

    print("file name $fileName");
    final destination = 'files/$fileName';
    try {
      final ref1 = FirebaseStorage.instance.ref(destination);
      await ref1.putFile(file);
      print("link ${ref1.fullPath}");
      var dowurl = await ref1.getDownloadURL();
      return dowurl;
    } catch (e) {
      return "";
    }
  }


}
