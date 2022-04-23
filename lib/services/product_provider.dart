import 'package:applore_assignment/firebase/firebase_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/product_model.dart';

class ProductProvider with ChangeNotifier {
  // init firestore refrence
  var firestore = FirebaseFirestore.instance;

  // stores fetched products
  List<ProductModel> products = [];

  // track if products fetching
  bool isLoading = false;

  // flag for more products available or not
  bool hasMore = true;

  // documents to be fetched per request
  int documentLimit = 10;

  // flag for last document from where next 10 records to be fetched
  DocumentSnapshot? lastDocument;

  updateLoader(bool status) {
    isLoading = status;
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      notifyListeners();
    });
  }

  Future resetPagination() async {
    products.clear();
    hasMore = true;
    lastDocument = null;
    return await getProducts();

  }

  /// Fetch product with pagination
 Future getProducts() async {

    print("start load data");
    if (!hasMore) {
      print('No More Products');
      return;
    }
    if (isLoading) {
      return;
    }
    updateLoader(true);

    QuerySnapshot querySnapshot;

    if (lastDocument == null) {
      querySnapshot = await firestore
          .collection(FirebaseHandler.productCollection)
          .orderBy('productName')
          .limit(documentLimit)
          .get();
    } else {
      querySnapshot = await FirebaseHandler.fetchFirstTimeData(
          lastDocument!, documentLimit);
    }
    if (querySnapshot.docs.length < documentLimit) {
      hasMore = false;
    }
    try {
      lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      products.addAll(querySnapshot.docs.map((e) => ProductModel.fromFirebase(e)));
    }catch (e){
      /// Todo : handle loading error
    }

    updateLoader(false);
  }
}
