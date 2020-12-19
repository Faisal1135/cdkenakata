import 'package:cdkenakata/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:woocommerce/woocommerce.dart';

class ProductProvider extends ChangeNotifier {
  List<WooProduct> _products = List<WooProduct>();
  List<WooProduct> get products => [..._products];
  List<WooProduct> _catproducts = List<WooProduct>();
  List<WooProduct> get catproducts => [..._catproducts];
  List<WooProductCategory> _tags = List<WooProductCategory>();
  List<WooProductCategory> get tags => [..._tags];
  List<WooProductVariation> _variations = [];
  List<WooProductVariation> get variations => [..._variations];

  int pageNo = 1;
  bool hasData = true;
  int catpage = 1;

  List<WooProductCategory> get fetchHomeCat =>
      tags.where((cat) => showCat.contains(cat.id)).toList();

  Future<void> fetchAndAddProducts() async {
    try {
      final fetchProducts =
          await wooCommerce.getProducts(page: pageNo, perPage: 50);
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

  Future<List<WooProductVariation>> fetchProductsVariations(
      WooProduct product) async {
    if (product.variations.isEmpty) {
      return List<WooProductVariation>();
    }
    final fetchVariation =
        await wooCommerce.getProductVariations(productId: product.id);
    return fetchVariation;
  }

  Future<void> fetchProductByTags(WooProductCategory tag,
      [bool isSameTag = false]) async {
    if (tag.count == 0) {
      return [];
    }

    if (isSameTag) {
      final wooProd = catproducts;
      final productByTAG = await wooCommerce.getProducts(
          category: tag.id.toString(), page: 2, perPage: 100);
      wooProd.addAll(productByTAG);
      _catproducts = wooProd;
      catpage++;
      notifyListeners();
    }

    final productByTAG = await wooCommerce.getProducts(
        category: tag.id.toString(), perPage: 100);
    _catproducts = productByTAG;
    notifyListeners();
  }

  Future<void> fetchTags() async {
    final fetchTags = await wooCommerce.getProductCategories(perPage: 100);
    fetchTags.removeWhere((tag) => tag.image == null);
    _tags = fetchTags;

    notifyListeners();
  }

  Future fetchtagAndProd() async {
    await fetchTags();

    await fetchAndAddProducts();
  }
}
