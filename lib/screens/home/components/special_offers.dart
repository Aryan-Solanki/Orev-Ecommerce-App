import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orev/screens/seemore/seemore.dart';
import 'package:orev/services/product_services.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatefulWidget {
  final List keys;
  final String card_title;
  const SpecialOffers({Key key, this.keys, this.card_title}) : super(key: key);
  @override
  _SpecialOffersState createState() => _SpecialOffersState(keys: keys);
}

class _SpecialOffersState extends State<SpecialOffers> {
  final List keys;
  _SpecialOffersState({this.keys});

  List<Widget> WidgetList = [];

  Future<List<Widget>> getAllCategories() async {
    ProductServices _services = ProductServices();
    List<Widget> finalListWidget = [];

    for (var k in keys) {
      var document = await _services.category.doc(k).get();
      WidgetList.add(new SpecialOfferCard(
        image: document.get("image"),
        category: document.get("name"),
        numOfBrands: document.get("num"),
        press: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SeeMore(
                      categoryId: document.get("id"),
                      title: document.get("name"))));
        },
      ));
    }
    setState(() {});
    // list.add(SizedBox(width: getProportionateScreenWidth(20)));
  }

  @override
  void initState() {
    getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: widget.card_title,
            press: () {},
            seemore: false,
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: WidgetList,
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key key,
    @required this.category,
    @required this.image,
    @required this.numOfBrands,
    @required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "$numOfBrands Products",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(10),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
