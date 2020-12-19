import 'package:cdkenakata/helpers/functions.dart';
import 'package:cdkenakata/providers/orderProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "order-route";

  Future<void> _onLoad(BuildContext context) async {
    final oids = await getOrders();
    if (oids.isEmpty) {
      return;
    }
    final oid = oids.map((e) => int.parse(e)).toList();
    await Provider.of<Order>(context, listen: false).fetchOrders(oid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _onLoad(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: GFLoader(
                type: GFLoaderType.square,
              ),
            );
          }

          if (snapshot.hasError) {
            basicAlert(context, "Something Went Wrong", "${snapshot.error}")
                .show();
            return Center(
              child: Text("${snapshot.error}"),
            );
          }

          final orders = Provider.of<Order>(context).orders;

          return EasyRefresh.custom(
            header: BezierHourGlassHeader(),
            footer: ClassicalFooter(),
            onRefresh: () => _onLoad(context),
            slivers: [
              SliverAppBar(
                title: Text('Your Orders'),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    if (orders.isEmpty)
                      Center(child: Text('You Have No Orders Yet'))
                    else
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: orders.length,
                        itemBuilder: (BuildContext context, int index) {
                          final ord = orders[index];
                          return ExpansionTile(
                            title: Text(ord.paymentMethodTitle),
                            subtitle: Text("Total " + ord.total + " TK"),
                            leading: CircleAvatar(
                              child: FittedBox(child: Text('${ord.status}')),
                              radius: 30,
                              backgroundColor: Colors.deepOrange,
                            ),
                            children: ord.lineItems
                                .map(
                                  (item) => ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.purple,
                                      child:
                                          Icon(Icons.arrow_circle_up_rounded),
                                    ),
                                    title: Text(item.name),
                                    subtitle: Text(item.price),
                                    trailing: Text(
                                      item.quantity.toString(),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
