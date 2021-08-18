import 'package:flutter/material.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/screens/home/components/home_header.dart';
import '../../../constants.dart';
import 'scrollview.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  final List<Product> productList;
  final String title;
  Body({this.productList, this.title});
  @override
  _BodyState createState() => _BodyState(productList: productList);
}

class _BodyState extends State<Body> {
  final List<Product> productList;
  _BodyState({this.productList});

  ScrollController _scrollController1 = ScrollController();
  final GlobalKey<AllItemsState> _myWidgetState = GlobalKey<AllItemsState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController1.addListener(() {
      double maxScroll = _scrollController1.position.maxScrollExtent;
      double currentScroll = _scrollController1.position.pixels;
      double delta = getProportionateScreenWidth(25);

      if (maxScroll - currentScroll < delta) {
        _myWidgetState.currentState.getMoreProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    refresh() {
      setState(() {});
    }

    return SafeArea(
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(
              key: UniqueKey(),
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: kPrimaryColor2,
                  child: SingleChildScrollView(
                    controller: _scrollController1,
                    child: Column(
                      children: [
                        AllItems(
                          scrollController: _scrollController1,
                          productList: productList,
                          title: widget.title,
                          notifyParent: refresh,
                          key: _myWidgetState,
                        ),
                        SizedBox(height: getProportionateScreenWidth(30)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
