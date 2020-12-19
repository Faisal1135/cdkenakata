import 'package:cdkenakata/helpers/functions.dart';
import 'package:cdkenakata/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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
      body: FutureBuilder(
        future: Provider.of<ProductProvider>(context, listen: false)
            .fetchProductByTags(tag),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: GFLoader(
              type: GFLoaderType.square,
            ));
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          // if (snapshot.data.isEmpty) {
          //   return Center(
          //     child: Text('There is no item in this Catagories'),
          //   );
          // }
          final products = Provider.of<ProductProvider>(context).catproducts;

          return EasyRefresh.custom(
            footer: ClassicalFooter(),
            onLoad: () => Provider.of<ProductProvider>(context, listen: false)
                .fetchProductByTags(tag, true),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    buildProductGrid(products),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
