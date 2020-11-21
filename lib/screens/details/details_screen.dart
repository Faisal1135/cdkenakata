import 'package:cdkenakata/helpers/functions.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';
import '../../screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  final WooProduct product;

  const DetailsScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color

      appBar: buildAppBar(context, product.name),
      body: Body(product: product),
    );
  }
}
