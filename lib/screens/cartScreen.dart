import 'package:cdkenakata/providers/cart_Provider.dart';
import 'package:cdkenakata/screens/createCustomet.dart';
import 'package:cdkenakata/widgets/cartItemCard.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routerName = "/carts";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context);
    return Consumer<CartProvider>(
      builder: (BuildContext context, CartProvider cart, Widget child) =>
          Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
        ),
        bottomSheet: InkWell(
          onTap: cart.totalAmount > 0
              ? () {
                  Navigator.pushNamed(context, CreateCustomerForm.routeName,
                      arguments: [
                        cart.items.values.toList(),
                        cart.totalAmount
                      ]);
                }
              : null,
          child: Container(
            child: Center(
                child: Text(
              'CheckOut',
              style: Theme.of(context).textTheme.headline5,
            )),
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, -1),
                  blurRadius: 6.0,
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Chip(
                      elevation: 4,
                      label: Text(
                        "\$ ${cart.totalAmount.toStringAsFixed(2)}",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: cart.items.values.toList().length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < cart.items.values.length) {
                    final currentCart = cart.items.values.toList()[index];
                    return CartitemCard(
                      currentCart: currentCart,
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Estimated Delivery Time:',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '25 min',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total Cost:',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\$${cart.totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 80.0),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 1.0,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ListView.builder(
//               itemCount: cart.items.length,
//               itemBuilder: (BuildContext context, int index) {
// return CartitemCard(
//   title: sortedCart[index].title,
//   price: sortedCart[index].price,
//   quantity: sortedCart[index].quantity,
//   id: cart.items.values.toList()[index].id,
//   productID: cart.items.keys.toList()[index],
// );
//               },
//             ),
