import 'package:cached_network_image/cached_network_image.dart';
import 'package:cdkenakata/helpers/functions.dart';
import 'package:cdkenakata/providers/cart_Provider.dart';
import 'package:cdkenakata/providers/product_provider.dart';
import 'package:cdkenakata/screens/details/components/description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';
import '../../constants.dart';
import '../../screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  final WooProduct product;

  const DetailsScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color

      appBar: buildAppBar(context, product.name),
      floatingActionButton: product.variations.isEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                    .addToItems(product: product);

                final alert = createAlertForCart(context, product.name);
                alert.show();
                Future.delayed(Duration(seconds: 1))
                    .then((_) => alert.dismiss());
              },
              label: Icon(Icons.add_shopping_cart),
            )
          : Container(),
      body: product.variations.isNotEmpty
          ? FutureBuilder<List<WooProductVariation>>(
              future: Provider.of<ProductProvider>(context, listen: false)
                  .fetchProductsVariations(product),
              builder: (BuildContext context,
                  AsyncSnapshot<List<WooProductVariation>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ModalProgressHUD(
                      inAsyncCall: true,
                      child: Body(
                        product: product,
                      ));
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                final variations = snapshot.data;

                return ListView(
                  children: [
                    Hero(
                        tag: "${product.id}",
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            imageUrl: product.images.first.src,
                            fit: BoxFit.cover,
                            width: 1000,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPaddin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: kDefaultPaddin),
                          ProductWithVariation(
                            product: product,
                            productVar: variations,
                          ),
                          SizedBox(height: kDefaultPaddin),
                          Description(product: product),
                        ],
                      ),
                    )
                  ],
                );
              },
            )
          : Body(
              product: product,
            ),
    );
  }
}

class ProductWithVariation extends StatefulWidget {
  final WooProduct product;
  final List<WooProductVariation> productVar;

  const ProductWithVariation({Key key, this.product, this.productVar})
      : super(key: key);
  @override
  _ProductWithVariationState createState() => _ProductWithVariationState();
}

class _ProductWithVariationState extends State<ProductWithVariation> {
  WooProductVariation selectedVariation;

  @override
  Widget build(BuildContext context) {
    WooProduct product = widget.product;
    List<WooProductVariation> productVar = widget.productVar;
    String price = selectedVariation?.price ?? product.price;
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: "Price\n", style: TextStyle(color: Colors.black)),
              TextSpan(
                text: "৳ $price",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        FormBuilderChoiceChip(
          selectedColor: Colors.deepPurple,
          alignment: WrapAlignment.spaceEvenly,
          attribute: 'payment',
          decoration: InputDecoration(
            labelText: 'Select a Variation',
          ),
          onChanged: (val) {
            setState(() {
              selectedVariation = val;
            });
          },
          options: productVar
              .map((item) => FormBuilderFieldOption(
                    value: item,
                    child: Text(item.attributes.first.option),
                  ))
              .toList(),
        ),
        SizedBox(
          height: kDefaultPaddin,
        ),
        RaisedButton.icon(
          color: Colors.pink.shade300,
          onPressed: () async {
            Provider.of<CartProvider>(context, listen: false)
                .addToItems(product: product, variation: selectedVariation);

            final alert = createAlertForCart(context, product.name);
            alert.show();
            Future.delayed(Duration(seconds: 1)).then((_) => alert.dismiss());
          },
          icon: Icon(Icons.add_shopping_cart_rounded),
          label: Text('Add to Cart'),
        )
      ],
    );
  }
}

// Widget getChips(WooProductVariation productVar) {
// return FormBuilderChoiceChip(
//   alignment: WrapAlignment.spaceEvenly,
//   attribute: 'payment',
//   decoration: InputDecoration(
//     labelText: 'Select a Variation',
//   ),
//   onChanged: (val) {},
//   options: productVar.attributes.first.option
//       .map((item) => FormBuilderFieldOption(
//             value: item,
//             child: Text(item),
//           ))
//       .toList(),
// );
// }

// Row(
//             children: <Widget>[
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                         text: "Price\n", style: TextStyle(color: Colors.black)),
//                     TextSpan(
//                       text: "\$${product.price}",
//                       style: Theme.of(context).textTheme.headline6.copyWith(
//                           color: Colors.black, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//               // SizedBox(width: kDefaultPaddin),
//             ],
//           )
