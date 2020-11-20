import 'package:cdkenakata/providers/cart_Provider.dart';
import 'package:flutter/material.dart';

class CartitemCard extends StatelessWidget {
  final Cart cart;

  const CartitemCard({Key key, this.cart}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final prod = cart.products;
    return Container();
  }
}
