import 'package:cdkenakata/providers/cart_Provider.dart';
import 'package:cdkenakata/screens/cartScreen.dart';
import 'package:cdkenakata/widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../screens/details/details_screen.dart';

import '../screens/home/components/item_card.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';

import '../constants.dart';

Widget buildProductGrid(List<WooProduct> products) {
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

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.pinkAccent,
    elevation: 0,
    // leading: IconButton(
    //   icon: SvgPicture.asset("assets/icons/back.svg"),
    //   onPressed: () {},
    // ),
    actions: <Widget>[
      IconButton(
        icon: SvgPicture.asset(
          "assets/icons/search.svg",
          // By default our  icon color is white
          color: kTextColor,
        ),
        onPressed: () {},
      ),
      Consumer<CartProvider>(
        builder: (_, carts, child) => Badge(
          child: child,
          value: carts.numberOfItems.toString(),
        ),
        child: IconButton(
          icon: Icon(
            Icons.add_shopping_cart,
            color: Colors.black,
          ),
          onPressed: () =>
              Navigator.of(context).pushNamed(CartScreen.routerName),
        ),
      ),
      SizedBox(width: kDefaultPaddin / 2)
    ],
  );
}

class ProductGrid extends StatelessWidget {
  final List<WooProduct> products;

  const ProductGrid({Key key, this.products}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
}
