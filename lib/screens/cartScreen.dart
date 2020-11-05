import 'package:cdkenakata/constants.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);
  static const routeName = "CartSCREEN";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: FutureBuilder<WooCart>(
        future: wooCommerce.getMyCart(),
        builder: (BuildContext context, AsyncSnapshot<WooCart> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          final cartItems = snapshot.data.items;

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (BuildContext context, int index) {
              final item = cartItems[index];

              return ListTile(
                leading: Image.network(item.images.first.src),
                title: Text(item.name),
                subtitle: Center(
                  child: Text(item.price),
                ),
                trailing: Text(item.quantity.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
