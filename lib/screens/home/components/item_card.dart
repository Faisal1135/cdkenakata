import 'package:cached_network_image/cached_network_image.dart';
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
      child: Card(
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Hero(
                tag: "${product.id}",
                child: Container(
                  padding: EdgeInsets.all(kDefaultPaddin),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            CachedNetworkImageProvider(product.images[0].src)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPaddin / 4, horizontal: kDefaultPaddin / 2),
              child: Text(
                product.name,
                style: TextStyle(color: kTextLightColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "\$${product.price}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  product.regularPrice != null
                      ? Text(
                          "${product.regularPrice}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
