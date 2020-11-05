import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../../constants.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final WooProduct product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: "${product.id}",
            child: Container(
              child: Image.network(
                product.images[0].src,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            product.name,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Price\n", style: TextStyle(color: Colors.black)),
                    TextSpan(
                      text: "\$${product.price}",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // SizedBox(width: kDefaultPaddin),
            ],
          )
        ],
      ),
    );
  }
}
