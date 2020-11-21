import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

String baseUrl = "https://cdkenakata.com";
String consumerKey = "ck_9b51da9d17e5eb13c6de9e67ff2db4f522785610";
String consumerSecret = "cs_9ec5e82f2911eeac6252797ea3f8afb3b1c16c84";
const kDefaultPaddin = 20.0;
WooCommerce wooCommerce = WooCommerce(
  baseUrl: baseUrl,
  consumerKey: consumerKey,
  consumerSecret: consumerSecret,
  isDebug: true,
);

List<int> showCat = [265, 29, 70, 47, 56, 83];
