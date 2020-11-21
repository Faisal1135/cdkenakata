import 'package:cached_network_image/cached_network_image.dart';
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
              child: CachedNetworkImage(
                imageUrl: product.images.first.src,
                fit: BoxFit.cover,
              )),
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

// Container(
//                     child: Image.network(
//                       product.images[0].src,
//                       fit: BoxFit.fill,
//                     ),
//                   );
// product.images.length > 1
//                 ? Container(
//                     height: 400,
//                     child: ListView(
//                       primary: false,
//                       shrinkWrap: true,
//                       scrollDirection: Axis.horizontal,
//                       children: product.images.map(
//                         (img) {
//                           return Container(
//                             child: CachedNetworkImage(
//                               fit: BoxFit.fill,
//                               imageUrl: img.src,
//                             ),
//                           );
//                         },
//                       ).toList(),
//                     ),
//                   )
//                 : Container(
//                     child: Image.network(
//                       product.images[0].src,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
