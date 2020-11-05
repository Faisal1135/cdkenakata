import 'package:cdkenakata/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:woocommerce/woocommerce.dart';

class ProductProvider extends ChangeNotifier {
  List<WooProduct> _products = List<WooProduct>();

  List<WooProduct> get products => [..._products];
  List<WooProductCategory> _tags = List<WooProductCategory>();
  List<WooProductCategory> get tags => [..._tags];

  int pageNo = 1;
  bool hasData = true;

  Future<void> fetchAndAddProducts() async {
    try {
      final fetchProducts =
          await wooCommerce.getProducts(page: pageNo, perPage: 10);
      if (fetchProducts.length < 10) {
        hasData = false;
      }
      _products.addAll(fetchProducts);
      pageNo++;

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<WooProduct>> fetchProductByTags(String tag) async {
    final productByTAG = await wooCommerce.getProducts(tag: tag);
    return productByTAG;
  }

  Future<void> fetchTags() async {
    final fetchTags = await wooCommerce.getProductCategories();
    _tags = fetchTags;

    notifyListeners();
  }

  Future fetchtagAndProd() async {
    await fetchTags();
    await fetchAndAddProducts();
  }
}
