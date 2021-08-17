import 'package:algolia/algolia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orev/components/AlgoliaApplication.dart';
import 'package:orev/screens/home/components/home_header.dart';

import '../size_config.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Algolia _algoliaApp = AlgoliaApplication.algolia;
  String _searchTerm;

  Future<List<AlgoliaObjectSnapshot>> _operation(String input) async {
    AlgoliaQuery query = _algoliaApp.instance.index("Posts").search(input);
    AlgoliaQuerySnapshot querySnap = await query.getObjects();
    List<AlgoliaObjectSnapshot> results = querySnap.hits;
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            HomeHeader(
              simplebutton: false,
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "✕",
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(15)),
                                    )),
                                SizedBox(
                                  width: getProportionateScreenWidth(20),
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "Laptop",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                          fontSize:
                                              getProportionateScreenWidth(18)),
                                    )),
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                            )
                          ],
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
