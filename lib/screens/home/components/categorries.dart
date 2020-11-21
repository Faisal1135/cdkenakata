import 'package:cdkenakata/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../helpers/functions.dart';

import '../../../constants.dart';

// We need satefull widget for our categories

class Categories extends StatelessWidget {
  // By default our first item will be selected

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<ProductProvider>(context).fetchHomeCat;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: buildCatagorieGrid(categories, context),
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
