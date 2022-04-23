import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../util/app_image.dart';

class ProductCard extends StatelessWidget {
  final ProductModel item;
  const ProductCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Flexible(
          child:FadeInImage.assetNetwork(placeholder: AppImage.placeholder, image: item.image, imageErrorBuilder: (e, f, d)=>Image.asset(AppImage.placeholder),),
        ),
        ListTile(
          title: Text(item.productName),
          subtitle: Text("Price : Rs.${item.price}/-"),
        ),
      ]),
    );
  }
}
