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

final List<String> imageList = [
  "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
];

List<Map<String, String>> paymentMethods = [
  {"softtech_bkash": "bKash"},
  {"cod": "Cash on Delivary"},
];
