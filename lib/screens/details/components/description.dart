import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../../constants.dart';

class Description extends StatelessWidget {
  const Description({
    Key key,
    @required this.product,
  }) : super(key: key);

  final WooProduct product;

  @override
  Widget build(BuildContext context) {
    final descp = product.description
        .replaceAll("<p>", "")
        .replaceAll("</p>", "")
        .replaceAll("<br />", "");
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kDefaultPaddin, horizontal: kDefaultPaddin),
      child: Text(
        descp,
        style: TextStyle(height: 1.5),
      ),
    );
  }
}
