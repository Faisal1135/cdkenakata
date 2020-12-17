import 'package:cached_network_image/cached_network_image.dart';
import 'package:cdkenakata/providers/cart_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartitemCard extends StatelessWidget {
  final Cart currentCart;

  const CartitemCard({Key key, this.currentCart}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        direction: DismissDirection.endToStart,
        key: ValueKey(currentCart.products.id.toString()),
        onDismissed: (direction) {
          Provider.of<CartProvider>(context, listen: false)
              .removeItem(currentCart.products.id.toString());
        },
        confirmDismiss: (_) {
          return showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Text("Are You Sure ?"),
                  content:
                      Text("Do you want to remove the item from the carts?"),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text("Yes")),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text("No"))
                  ],
                );
              });
        },
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            size: 40,
            color: Colors.white,
          ),
          alignment: Alignment.centerRight,
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          padding: EdgeInsets.only(right: 20),
        ),
        child: _buildCartItem(context, currentCart));
  }
}

Widget _buildCartItem(BuildContext context, Cart currentCart) {
  final prod = currentCart.products;
  final price = currentCart.quantity * currentCart.price ?? 0.0;
  String subtxt = prod.categories.first.name;
  if (currentCart.variation != null) {
    subtxt = currentCart.variation.attributes.first.option;
  }
  return Consumer<CartProvider>(
    builder: (BuildContext context, CartProvider cart, Widget child) =>
        Container(
      padding: EdgeInsets.all(20.0),
      // height: 200.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: CachedNetworkImage(
                    height: 150,
                    imageUrl: currentCart.products.images.first.src,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          currentCart.products.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          subtxt,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.0),
                        // SizedBox(height: 10.0),
                        Container(
                          width: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              width: 0.8,
                              color: Colors.black54,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    print("--- Preswws");
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .removeSingelItem(prod.id.toString());
                                  },
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 27,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(width: 20.0),
                              Expanded(
                                child: Text(
                                  currentCart.quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () => Provider.of<CartProvider>(
                                          context,
                                          listen: false)
                                      .addToItems(product: prod),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Text(
              price.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
