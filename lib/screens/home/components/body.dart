import 'package:cdkenakata/helpers/functions.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';
import '../../../constants.dart';
import 'categorries.dart';

class Body extends StatelessWidget {
  final List<WooProduct> products;

  const Body({Key key, this.products}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPaddin, vertical: kDefaultPaddin),
          child: Text(
            "Catagories",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Categories(),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPaddin, vertical: kDefaultPaddin),
          child: Text(
            "All Products",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        buildProductGrid(products),
      ],
    );
  }
}
