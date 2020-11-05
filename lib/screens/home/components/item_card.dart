import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../../constants.dart';

class ItemCard extends StatelessWidget {
  final WooProduct product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Hero(
              tag: "${product.id}",
              child: Container(
                // padding: EdgeInsets.all(kDefaultPaddin),
                // For  demo we use fixed height  and width
                // Now we dont need them
                // height: 180,
                // width: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(product.images[0].src)),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              product.name,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${product.price}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              product.regularPrice != null
                  ? Text(
                      "\$${product.regularPrice}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
