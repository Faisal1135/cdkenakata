import 'package:cdkenakata/providers/product_provider.dart';
import 'package:cdkenakata/screens/cartScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: FutureBuilder(
        future: Provider.of<ProductProvider>(context, listen: false)
            .fetchtagAndProd(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final prodcutsProv = Provider.of<ProductProvider>(context);
          final prodcuts = prodcutsProv.products;

          return EasyRefresh.custom(
            onLoad: () => Provider.of<ProductProvider>(context, listen: false)
                .fetchAndAddProducts(),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Body(
                      products: prodcuts,
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/cart.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () async {
            await Navigator.pushNamed(context, CartScreen.routeName);
          },
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
