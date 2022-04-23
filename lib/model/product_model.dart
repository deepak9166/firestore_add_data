import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  late  final String productName;
  late  final String desc;
  late  final String price;
 late  final String image;


  ProductModel({required this.desc ,required this.image,required  this.price,required  this.productName});


  ProductModel.fromFirebase(QueryDocumentSnapshot<Object?> data){
    productName = data.get("productName") ?? "";
     desc = data.get("desc") ?? "";
    price = data.get("price") ?? "";
     image = data.get("image") ?? "";

  }

}