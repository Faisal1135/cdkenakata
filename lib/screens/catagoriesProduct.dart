import 'package:cdkenakata/helpers/functions.dart';
import 'package:cdkenakata/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';

class CatagoriesProduct extends StatelessWidget {
  static const routeName = '/catagoriesPageDetails';
  @override
  Widget build(BuildContext context) {
    final tag = ModalRoute.of(context).settings.arguments as WooProductCategory;
    return Scaffold(
      appBar: AppBar(
        title: Text(tag.name + ' (' + tag.count.toString() + ')'),
      ),
      body: FutureBuilder<List<WooProduct>>(
        future: Provider.of<ProductProvider>(context, listen: false)
            .fetchProductByTags(tag),
        initialData: [],
        builder:
            (BuildContext context, AsyncSnapshot<List<WooProduct>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: GFLoader(
              type: GFLoaderType.square,
            ));
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.data.isEmpty) {
            return Center(
              child: Text('There is no item in this Catagories'),
            );
          }

          return buildProductGrid(snapshot.data);
        },
      ),
    );
  }
}
