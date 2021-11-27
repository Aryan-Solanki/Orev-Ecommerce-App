import 'package:flutter/material.dart';
import 'package:orev/screens/home/components/home_header.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'AllItems.dart';

class CategoryPageMobile extends StatefulWidget {
  final String categoryId;
  final String title;
  CategoryPageMobile({this.categoryId, this.title});
  @override
  _CategoryPageMobileState createState() =>
      _CategoryPageMobileState(categoryId: categoryId);
}

class _CategoryPageMobileState extends State<CategoryPageMobile> {
  final String categoryId;
  _CategoryPageMobileState({this.categoryId});

  ScrollController _scrollController = ScrollController();
  final GlobalKey<AllItemsState> _myWidgetState = GlobalKey<AllItemsState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = getProportionateScreenWidth(25);

      if (maxScroll - currentScroll < delta) {
        _myWidgetState.currentState.getMoreProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    refresh() {
      setState(() {
        print("Final Set State");
      });
    }

    return SafeArea(
      child: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: kPrimaryColor2,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(20)),
                  HomeHeader(
                    key: UniqueKey(),
                  ),
                  SizedBox(height: getProportionateScreenWidth(10)),
                  AllItems(
                    categoryId: categoryId,
                    title: widget.title,
                    notifyParent: refresh,
                    key: _myWidgetState,
                    scrollController: _scrollController,
                  ),
                  SizedBox(height: getProportionateScreenWidth(30)),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
