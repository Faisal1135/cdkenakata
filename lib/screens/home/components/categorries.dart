import 'package:cached_network_image/cached_network_image.dart';
import 'package:cdkenakata/providers/product_provider.dart';
import 'package:cdkenakata/screens/catagoriesProduct.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../../constants.dart';

// We need satefull widget for our categories

class Categories extends StatelessWidget {
  // By default our first item will be selected

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<ProductProvider>(context).fetchHomeCat;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: _buildCarosol(categories, context),
    );
  }

  Widget _buildCarosol(
      List<WooProductCategory> catagorie, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: kDefaultPaddin / 2,
        crossAxisSpacing: kDefaultPaddin / 2,
        childAspectRatio: 0.75,
        children: [
          ...catagorie.map((cat) => buildCard(context, cat)).toList(),
          InkWell(
            onTap: () {},
            child: GFAvatar(
              backgroundColor: Colors.amber,
              shape: GFAvatarShape.standard,
              child: Text('More'),
            ),
          ),
        ],
      ),
    );
  }

  InkWell buildCard(context, WooProductCategory catagorie) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CatagoriesProduct.routeName,
            arguments: catagorie);
      },
      child: GFAvatar(
        backgroundImage: CachedNetworkImageProvider(catagorie.image?.src),
        shape: GFAvatarShape.standard,
        child: Text(
          catagorie.name,
          style: const TextStyle(
              color: Colors.white, backgroundColor: Colors.black45),
        ),
      ),
    );
  }
}

// GFItemsCarousel(
//       rowCount: 3,
//       children: catagorie.map(
//         (cat) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.pushNamed(context, CatagoriesProduct.routeName,
//                   arguments: cat.id.toString(),);
//             },
//             child: Column(
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(5.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                     child: cat.image != null
//                         ? CachedNetworkImage(
//                             imageUrl: cat.image?.src,
//                             fit: BoxFit.cover,
//                             width: 1000,
//                           )
//                         : Container(), //Image.network(url, fit: BoxFit.cover, width: 1000.0),
//                   ),
//                 ),
//                 Text(cat.name)
//               ],
//             ),
//           );
//         },
//       ).toList(),
//     );
