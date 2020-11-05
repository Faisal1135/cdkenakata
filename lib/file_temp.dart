import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WooCommerce Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "Woo Commerce Demo"),
    );
  }
}

String baseUrl = "https://cdkenakata.com";
String consumerKey = "ck_9b51da9d17e5eb13c6de9e67ff2db4f522785610";
String consumerSecret = "cs_9ec5e82f2911eeac6252797ea3f8afb3b1c16c84";

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<WooProduct> products = [];
  List<WooProduct> featuredProducts = [];
  List<WooProductCategory> catagory = [];
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: baseUrl,
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
    isDebug: true,
  );

  getProducts() async {
    products = await wooCommerce.getProducts(page: 1, perPage: 30);
    setState(() {});
    print(products.toString());
  }

  @override
  void initState() {
    super.initState();
    //You would want to use a feature builder instead.
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'My Awesome Shop',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .apply(color: Colors.blueGrey),
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                mainAxisSpacing: 2,
                crossAxisSpacing: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final product = products[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          // height: 230,
                          // width: 200,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  product.images[0].src,
                                ),
                                fit: BoxFit.cover),
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          //child: Image.network(product.images[0].src, fit: BoxFit.cover,),
                        ),
                      ),
                      Text(
                        product.name ?? 'Loading...',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .apply(color: Colors.blueGrey),
                      ),
                      Text(
                        '\$' + product.price.toString() ?? '',
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  );
                },
                childCount: products.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
