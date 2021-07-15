import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orev/services/product_services.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductServices _services = ProductServices();

    List<Widget> getAllCategories(snapshot) {
      // snapshot.data.documents.map<Widget>((document) {
      //   return new ListTile(
      //     title: new Text(document['name']),
      //     subtitle: new Text("Class"),
      //   );
      // }).toList();

      List<Widget> list =
          snapshot.data.docs.map<Widget>((DocumentSnapshot document) {
        return new SpecialOfferCard(
          image: document.get("image"),
          category: document.get("name"),
          numOfBrands: document.get("num"),
          press: () {},
        );
      }).toList();
      // list.add(SizedBox(width: getProportionateScreenWidth(20)));

      return list;
    }

    return FutureBuilder<QuerySnapshot>(
      future: _services.category.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data.docs.isEmpty) {
          return Container(); //if no data
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SectionTitle(
                title: "Special for you",
                press: () {},
              ),
            ),
            SizedBox(height: getProportionateScreenWidth(20)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                // SpecialOfferCard(
                //   image: "assets/images/Image Banner 2.png",
                //   category: "Smartphone",
                //   numOfBrands: 18,
                //   press: () {},
                // ),
                // SpecialOfferCard(
                //   image: "assets/images/Image Banner 3.png",
                //   category: "Fashion",
                //   numOfBrands: 24,
                //   press: () {},
                // ),
                children: getAllCategories(snapshot),
              ),
            ),
          ],
        );

        // return Column(
        //   children: [
        //     Container(
        //       width: MediaQuery.of(context).size.width,
        //       height: 45,
        //       decoration: BoxDecoration(
        //           color: Colors.grey[300],
        //           borderRadius: BorderRadius.circular(4)),
        //       child: Row(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.only(left: 10),
        //             child: Text(
        //               '${snapshot.data.docs.length} Items',
        //               style: TextStyle(
        //                   fontWeight: FontWeight.bold, color: Colors.grey[600]),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     new ListView(
        //       padding: EdgeInsets.zero,
        //       shrinkWrap: true,
        //       physics: NeverScrollableScrollPhysics(),
        //       children: snapshot.data.docs.map((DocumentSnapshot document) {
        //         return new SpecialOfferCard(
        //           image: "assets/images/Image Banner 3.png",
        //           category: "Fashion",
        //           numOfBrands: 24,
        //           press: () {},
        //         );
        //       }).toList(),
        //     ),
        //   ],
        // );
      },
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
                        TextSpan(text: "$numOfBrands Products")
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
