import 'package:cdkenakata/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:woocommerce/woocommerce.dart';

class Order extends ChangeNotifier {
  List<WooOrder> _orders = [];
  List<WooOrder> get orders => [..._orders];

  Future<WooOrder> fetchOrderByid(int id) async {
    final forder = await wooCommerce.getOrderById(id);
    return forder;
  }

  Future<void> fetchOrders(List<int> oid) async {
    final orderLst = <WooOrder>[];
    Future.forEach(oid, (id) async {
      final ord = await fetchOrderByid(id);
      orderLst.add(ord);
    }).then((_) {
      _orders = orderLst;
      notifyListeners();
    }).catchError((e) {
      logger.e(e.toString());
      throw Exception(e);
    });
  }
}
