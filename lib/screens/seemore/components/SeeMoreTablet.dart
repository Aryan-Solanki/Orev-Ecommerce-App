import 'package:flutter/material.dart';
import 'package:orev/screens/home/components/TabletHomeHeader.dart';
import 'package:orev/screens/home/components/home_header.dart';
import '../../../constants.dart';
import 'scrollview.dart';
import '../../../size_config.dart';

class SeeMoreTablet extends StatefulWidget {
  final String categoryId;
  final String title;
  SeeMoreTablet({this.categoryId, this.title});
  @override
  _SeeMoreTabletState createState() =>
      _SeeMoreTabletState(categoryId: categoryId);
}

class _SeeMoreTabletState extends State<SeeMoreTablet> {
  final String categoryId;
  _SeeMoreTabletState({this.categoryId});

  ScrollController _scrollController = ScrollController();
  final GlobalKey<AllItemsState> _myWidgetState = GlobalKey<AllItemsState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = getProportionateScreenHeight(25);

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
            TabletHomeHeader(
              key: UniqueKey(),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: kPrimaryColor2,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        AllItems(
                          categoryId: categoryId,
                          title: widget.title,
                          notifyParent: refresh,
                          key: _myWidgetState,
                          scrollController: _scrollController,
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
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
