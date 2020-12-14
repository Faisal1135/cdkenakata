import 'package:cdkenakata/constants.dart';
import 'package:cdkenakata/providers/cart_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:woocommerce/woocommerce.dart';

Widget getTextFiled(BuildContext context, String name, String label,
    {List<Function> validator, TextInputType keyBT}) {
  return FormBuilderTextField(
    name: name,
    decoration: InputDecoration(
      labelText: label,
    ),
    validator: FormBuilderValidators.compose(
        [FormBuilderValidators.required(context), ...validator ?? []]),
    keyboardType: keyBT ?? TextInputType.text,
  );
}

List<String> address = [
  "Address_1",
  "Address_2",
  "City",
  "Company",
  "State",
  "PostCode"
];

//  getTextFiled(context, "address1", "Address_1"),
//     getTextFiled(context, "address2", "Address_2"),
//     getTextFiled(context, "city", "City"),
//     getTextFiled(context, "company", "Company"),
//     getTextFiled(context, "state", "Uplozila"),
//     getTextFiled(
//       context,
//       "postCode",
//       "PostCode",
//     ),

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

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final cartItem = ModalRoute.of(context).settings.arguments as List<Cart>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                      child: Text(
                    'Personal Info',
                    style: Theme.of(context).textTheme.headline6,
                  )),
                  getTextFiled(context, "email", "Enter Your Email",
                      validator: [FormBuilderValidators.email(context)],
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
                        FormBuilderValidators.minLength(context, 11),
                        FormBuilderValidators.numeric(context)
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
                      setState(() {
                        isSame = val;
                      });
                    },
                    initialValue: isSame,
                    name: 'accept_terms',
                    title: Text('Shipping And Billing Place Are Same'),
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
                  ElevatedButton(
                      onPressed: () async {
                        final custormer = WooCustomer();

                        final newCustom =
                            await wooCommerce.createCustomer(custormer);
                      },
                      child: Text(
                        'Submit',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
