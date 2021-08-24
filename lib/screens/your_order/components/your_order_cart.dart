import 'package:flutter/material.dart';
import 'package:orev/components/rounded_icon_btn.dart';
import 'package:orev/models/Cart.dart';
import 'package:orev/models/Order.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/providers/auth_provider.dart';
import 'package:orev/screens/your_order/components/your_order_detail.dart';
import 'package:orev/services/product_services.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class YouOrderCard extends StatefulWidget {
  const YouOrderCard({
    Key key,
    @required this.order,
    @required this.notifyParent,
  }) : super(key: key);

  final Order order;
  final Function() notifyParent;

  @override
  _YouOrderCardState createState() => _YouOrderCardState();
}

class _YouOrderCardState extends State<YouOrderCard> {
  String user_key;

  @override
  void initState() {
    user_key = AuthProvider().user.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => YourOrderDetail(
                  order: widget.order,
                )));
        // Navigator.pushNamed(context, YourOrderDetail.routeName);
      },
      child: Row(
        children: [
          SizedBox(
            width: getProportionateScreenWidth(88),
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(widget.order.product.variant.images[0]),
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(15)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: getProportionateScreenHeight(50),
                width: getProportionateScreenWidth(210),
                child: Text(
                  widget.order.product.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(15)),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Text(
                widget.order.orderStatus,
                style: TextStyle(fontSize: getProportionateScreenHeight(14)),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: getProportionateScreenHeight(25),
          ),
        ],
      ),
    );
  }
}
