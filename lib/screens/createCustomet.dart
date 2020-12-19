import 'package:cdkenakata/constants.dart';
import 'package:cdkenakata/helpers/functions.dart';
import 'package:cdkenakata/providers/cart_Provider.dart';
import 'package:cdkenakata/screens/orderScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:woocommerce/models/order.dart' as wo;
import 'package:woocommerce/models/order.dart';

Widget getTextFiled(BuildContext context, String name, String label,
    {List<Function> validator, TextInputType keyBT}) {
  return FormBuilderTextField(
    attribute: name,
    decoration: InputDecoration(
      labelText: label,
    ),
    validators: [FormBuilderValidators.required(), ...validator ?? []],
    keyboardType: keyBT ?? TextInputType.text,
  );
}

Future<wo.WooOrder> createCustomer(
    Map<String, dynamic> data, bool isSame, List<Cart> items) async {
  Shipping shipping;
  if (isSame) {
    shipping = Shipping(
        firstName: data["fname"],
        lastName: data["lname"],
        company: data["bCompany"],
        address1: data["bAddress_1"],
        address2: data["bAddress_2"],
        city: data["bCity"],
        state: data["bState"],
        postcode: data["bPostCode"],
        country: 'BN');
  } else {
    shipping = Shipping(
      firstName: data["fname"],
      lastName: data["lname"],
      company: data["sCompany"],
      address1: data["sAddress_1"],
      address2: data["sAddress_2"],
      city: data["sCity"],
      state: data["sState"],
      postcode: data["sPostCode"],
      country: "BN",
    );
  }

  final billing = Billing(
      firstName: data["fname"],
      lastName: data["lname"],
      email: data["email"],
      phone: data["bkphone"] ?? data["phone"],
      company: data["bCompany"],
      address1: data["bAddress_1"],
      address2: data["bAddress_2"],
      city: data["bCity"],
      state: data["bState"],
      postcode: data["bPostCode"],
      country: "BN");

  final cart = items.map((i) {
    if (i.variation != null) {
      return {
        "product_id": i.products.id,
        "quantity": i.quantity,
        "variation_id": i.variation.id
      };
    }
    return {
      "product_id": i.products.id,
      "quantity": i.quantity,
    };
  }).toList();

  final customer = {
    "payment_method": data["payment"].toString().split("/").first,
    "payment_method_title": data["payment"].toString().split("/").last,
    "line_items": cart,
    "billing": billing.toJson(),
    "shipping": shipping.toJson(),
    "transaction_id": data["bktrid"],

    "set_paid": false,

    // password: 'test1234',
    // email: data["email"],
    // firstName: data["fname"],
    // lastName: data["lname"],
    // username: "${data["fname"]}_${data["lname"]}",
    // billing: Billing(
    //     firstName: data["fname"],
    //     lastName: data["lname"],
    //     email: data["email"],
    //     phone: data["phone"],
    //     company: data["bCompany"],
    //     address1: data["bAddress_1"],
    //     address2: data["bAddress_2"],
    //     city: data["bCity"],
    //     state: data["bState"],
    //     postcode: data["bPostCode"],
    //     country: "BN"),
    // shipping: shipping,
  };

  final newOrder = await wooCommerce.post("orders", customer).then(
        (value) => wo.WooOrder.fromJson(value),
      );
  return newOrder;
}

// final id = DateTime.now().microsecondsSinceEpoch;
// final customer = WooCustomer(
//   password: 'test1234',
//   id: id,
//   email: data["email"],
//   firstName: data["fname"],
//   lastName: data["lname"],
//   username: "${data["fname"]}_${data["lname"]}",
//   billing: Billing(
//       firstName: data["fname"],
//       lastName: data["lname"],
//       email: data["email"],
//       phone: data["phone"],
//       company: data["bCompany"],
//       address1: data["bAddress_1"],
//       address2: data["bAddress_2"],
//       city: data["bCity"],
//       state: data["bState"],
//       postcode: data["bPostCode"],
//       country: "BN"),
//   shipping: shipping,
// );
// final isCreated = await wooCommerce.createCustomer(customer);
// if (isCreated) {
//   wooCommerce.getCustomerById(id: id).then((value) => print(value));
// }

List<String> address = [
  "Address_1",
  "Address_2",
  "City",
  "Company",
  "State",
  "PostCode"
];

List<Widget> getAddress(BuildContext context, String title, String type) {
  return [
    Text(
      title,
      style: Theme.of(context).textTheme.headline6,
    ),
    ...address.map(
      (add) => getTextFiled(context, "$type$add", add),
    ),
  ];
}

class CreateCustomerForm extends StatefulWidget {
  static const routeName = "create-customer-form";

  @override
  _CreateCustomerFormState createState() => _CreateCustomerFormState();
}

class _CreateCustomerFormState extends State<CreateCustomerForm> {
  bool isLoading = false;
  bool isSame = false;
  Map<String, dynamic> initMap = {};
  bool isBkash = false;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final args = ModalRoute.of(context).settings.arguments as List;
    final cartItem = args.first as List<Cart>;
    final totalPrice = args.last as double;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: FormBuilder(
                initialValue: initMap,
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      'Personal Info',
                      style: Theme.of(context).textTheme.headline6,
                    )),
                    getTextFiled(context, "email", "Enter Your Email",
                        validator: [FormBuilderValidators.email()],
                        keyBT: TextInputType.emailAddress),
                    getTextFiled(
                      context,
                      "fname",
                      "Frist Name",
                    ),
                    getTextFiled(
                      context,
                      "lname",
                      "Last Name",
                    ),
                    getTextFiled(context, "phone", "Enter Your Phone No ",
                        validator: [
                          FormBuilderValidators.minLength(11),
                          FormBuilderValidators.numeric()
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    ...getAddress(context, "Billing Address", "b"),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderCheckbox(
                      onChanged: (val) {
                        // isSame = !isSame;
                        setState(() {
                          _formKey.currentState.save();
                          print(_formKey.currentState.value);
                          initMap = _formKey.currentState.value;
                          isSame = val;
                        });
                      },
                      initialValue: isSame,
                      attribute: 'bnse',
                      label: Text('Shipping And Billing Place Are Same'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    !isSame
                        ? Column(
                            children:
                                getAddress(context, "Shipping Address", "s"),
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    Text('You Need TO PAY $totalPrice'),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderChoiceChip(
                      alignment: WrapAlignment.spaceEvenly,
                      attribute: 'payment',
                      decoration: InputDecoration(
                        labelText: 'Select an Payment option',
                      ),
                      onChanged: (val) {
                        if (val == "softtech_bkash/bKash") {
                          setState(() {
                            _formKey.currentState.save();
                            initMap = _formKey.currentState.value;
                            isBkash = true;
                          });
                        } else {
                          setState(() {
                            _formKey.currentState.save();
                            initMap = _formKey.currentState.value;
                            isBkash = false;
                          });
                        }
                      },
                      options: paymentMethods
                          .map((item) => FormBuilderFieldOption(
                                value:
                                    item.keys.first + '/' + item.values.first,
                                child: Text(item.values.first),
                              ))
                          .toList(),
                    ),
                    if (isBkash)
                      getTextFiled(context, "bkphone", "Your Bkash phone No",
                          keyBT: TextInputType.number),
                    if (isBkash)
                      getTextFiled(
                          context, "bktrid", "Your Bkash Transaction Id"),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.saveAndValidate()) {
                          print(_formKey.currentState.value);

                          setState(() {
                            isLoading = true;
                          });

                          await createCustomer(
                                  _formKey.currentState.value, isSame, cartItem)
                              .then((wo) {
                                addtosharedPref(wo.id.toString());
                                return wo;
                              })
                              .then(
                                (wo) => basicAlert(
                                        context,
                                        "Order placed Succesfull",
                                        "Your Order ID - ${wo.status} ${wo.id}")
                                    .show()
                                    .then((_) => Navigator.pushNamed(
                                        context, OrderScreen.routeName)),
                              )
                              .catchError((e) => basicAlert(
                                  context, "Somethings went Wrong", "$e"));
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Text(
                        'Submit',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
