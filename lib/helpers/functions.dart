import '../screens/details/details_screen.dart';

import '../screens/home/components/item_card.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';

import '../constants.dart';

buildProductGrid(List<WooProduct> products) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
    child: GridView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: kDefaultPaddin,
        crossAxisSpacing: kDefaultPaddin,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) => ItemCard(
        product: products[index],
        press: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              product: products[index],
            ),
          ),
        ),
      ),
    ),
  );
}
