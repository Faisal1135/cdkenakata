import 'package:flutter/foundation.dart';
import 'package:woocommerce/woocommerce.dart';

class Cart {
  final String id;
  final WooProduct products;
  final int quantity;
  final WooProductVariation variation;
  final double price;
  Cart({
    this.id,
    this.products,
    this.quantity,
    this.variation,
    this.price,
  });

  Cart copyWith({
    String id,
    WooProduct products,
    int quantity,
    WooProductVariation variation,
    double price,
  }) {
    return Cart(
      id: id ?? this.id,
      products: products ?? this.products,
      quantity: quantity ?? this.quantity,
      variation: variation ?? this.variation,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return 'Cart(id: $id, products: $products, quantity: $quantity, variation: $variation, price: $price)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Cart &&
        o.id == id &&
        o.products == products &&
        o.quantity == quantity &&
        o.variation == variation &&
        o.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        products.hashCode ^
        quantity.hashCode ^
        variation.hashCode ^
        price.hashCode;
  }
}

class CartProvider extends ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get items => {..._items};

  int get numberOfItems => _items.length;

  double get totalAmount {
    double total = 0.0;

    _items.forEach((k, cart) {
      total += cart.price * cart.quantity;
    });
    return total;
  }

  void addToItems(
      {@required WooProduct product, WooProductVariation variation}) {
    String price = variation?.price ?? product.price;
    if (_items.containsKey(product.id.toString())) {
      // changing quantity
      _items.update(product.id.toString(), (existingCart) {
        return existingCart.copyWith(quantity: existingCart.quantity + 1);
      });
    } else {
      _items.putIfAbsent(
        product.id.toString(),
        () => Cart(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          products: product,
          price: double.parse(price),
          quantity: 1,
          variation: variation,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingelItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      print("enter update");
      _items.update(
          productId,
          (existingItem) =>
              existingItem.copyWith(quantity: existingItem.quantity - 1));
    } else {
      _items.remove(productId);
      print("enter remove total");
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
