import 'package:cdkenakata/providers/product_provider.dart';
import 'package:cdkenakata/screens/cartScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './constants.dart';
import './screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        routes: {
          CartScreen.routeName: (context) => CartScreen(),
        },
      ),
    );
  }
}
