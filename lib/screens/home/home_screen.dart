import 'package:cdkenakata/helpers/functions.dart';
import 'package:cdkenakata/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import '../../screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'CD Kenakata'),
      body: FutureBuilder(
        future: Provider.of<ProductProvider>(context, listen: false)
            .fetchtagAndProd(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final prodcutsProv = Provider.of<ProductProvider>(context);
          final prodcuts = prodcutsProv.products;

          return EasyRefresh.custom(
            onLoad: () => Provider.of<ProductProvider>(context, listen: false)
                .fetchAndAddProducts(),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Body(
                      products: prodcuts,
                    )
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
