import 'package:applore_assignment/firebase/firebase_handler.dart';
import 'package:applore_assignment/services/product_provider.dart';
import 'package:applore_assignment/util/route_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../components/product_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  // listener for grid view scrolling
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    context.read<ProductProvider>().getProducts();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        context.read<ProductProvider>().getProducts();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<ProductProvider>(builder: (context, value, child) => value.isLoading && value.products.isNotEmpty  ?  const SizedBox(
          height: 80,
          child: Center(child: CircularProgressIndicator())) : const SizedBox()),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteGenrator.addProduct);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          // primary: true,
          onRefresh: _onRefresh,
          controller: _refreshController,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  var product = productProvider.products;

                  print("current loaded product ${product.length}");
                  return SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          var item = product[index];
                          return product.isEmpty
                              ? Center(
                                  child: Text("no data",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!),
                                )
                              : ProductCard(
                                  item: item,
                                );
                        },
                        childCount: product.length,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 20,
                          crossAxisCount: 2,
                          crossAxisSpacing: 20));
                },
              )
            ],
          )),
    );
  }

  void _onRefresh() async {
    context.read<ProductProvider>().resetPagination().then((value) {
      _refreshController.refreshCompleted();
      print("refresh done");
    }).onError((error, stackTrace) {
      _refreshController.refreshCompleted();
    });
  }
}
