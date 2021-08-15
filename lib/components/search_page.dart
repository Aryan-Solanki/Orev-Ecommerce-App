import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orev/screens/home/components/home_header.dart';

import '../size_config.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            HomeHeader(simplebutton: false,),
            SizedBox(height: getProportionateScreenHeight(10)),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
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
                                  onTap: (){

                                  },
                                    child: Text("✕",style: TextStyle(fontSize: getProportionateScreenWidth(15)),)
                                ),
                                SizedBox(width: getProportionateScreenWidth(20),),
                                GestureDetector(
                                  onTap: (){
                                    
                                  },
                                    child: Text("Laptop",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: getProportionateScreenWidth(18)),)
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                            )
                          ],
                        );
                      }
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
