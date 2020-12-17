import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:woocommerce/woocommerce.dart';

import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatelessWidget {
  final WooProduct product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    return ListView(
      children: [
        ProductTitleWithImage(product: product),

        Description(product: product),
        // CounterWithFavBtn(),
        // AddToCart(product: product)
      ],
    );
  }
}

Widget getChips(WooProduct product) {
  return FormBuilderChoiceChip(
    alignment: WrapAlignment.spaceEvenly,
    attribute: 'payment',
    decoration: InputDecoration(
      labelText: 'Select a Variation',
    ),
    onChanged: (val) {},
    options: product.attributes.first.options
        .map((item) => FormBuilderFieldOption(
              value: item,
              child: Text(item),
            ))
        .toList(),
  );
}

// SizedBox(
//             height: size.height,
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   // margin: EdgeInsets.only(top: size.height * 0.3),
//                   // padding: EdgeInsets.only(
//                   //   top: size.height * 0.12,
//                   //   left: kDefaultPaddin,
//                   //   right: kDefaultPaddin,
//                   // ),
//                   // // height: 500,
//                   // decoration: BoxDecoration(
//                   //   color: Colors.white,
//                   //   borderRadius: BorderRadius.only(
//                   //     topLeft: Radius.circular(24),
//                   //     topRight: Radius.circular(24),
//                   //   ),
//                   // ),
//                   child: ListView(
//                     children: <Widget>[
//                       // ColorAndSize(product: product),
//                       SizedBox(height: kDefaultPaddin / 2),
//                       Description(product: product),
//                       SizedBox(height: kDefaultPaddin / 2),
//                       CounterWithFavBtn(),
//                       SizedBox(height: kDefaultPaddin / 2),
//                       AddToCart(product: product)
//                     ],
//                   ),
//                 ),
//                 ProductTitleWithImage(product: product)
//               ],
//             ),
//           )
