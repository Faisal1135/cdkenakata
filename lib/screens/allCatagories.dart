import 'package:cdkenakata/helpers/functions.dart';
import 'package:cdkenakata/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCatagories extends StatelessWidget {
  static const routeName = '/all-catagories';
  @override
  Widget build(BuildContext context) {
    final allCat = Provider.of<ProductProvider>(context).tags;
    return Scaffold(
      appBar: buildAppBar(context, "All Catagories"),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildCatagorieGrid(allCat, context),
          )
        ],
      ),
    );
  }
}
