import 'package:cached_network_image/cached_network_image.dart';
import 'package:cdkenakata/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_items_carousel.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../../constants.dart';

// We need satefull widget for our categories

class Categories extends StatelessWidget {
  // By default our first item will be selected

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<ProductProvider>(context).tags;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
        child: _buildCarosol(categories));
  }

  Widget _buildCarosol(List<WooProductCategory> catagorie) {
    return GFItemsCarousel(
      rowCount: 3,
      children: catagorie.map(
        (cat) {
          return GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: cat.image != null
                        ? CachedNetworkImage(
                            imageUrl: cat.image?.src,
                            fit: BoxFit.cover,
                            width: 1000,
                          )
                        : Container(), //Image.network(url, fit: BoxFit.cover, width: 1000.0),
                  ),
                ),
                Text(cat.name)
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
