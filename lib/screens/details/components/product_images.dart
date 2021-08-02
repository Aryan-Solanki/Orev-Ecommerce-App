import 'package:flutter/material.dart';
import 'package:orev/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key key,
    @required this.product,
    @required this.currentVarient,
  }) : super(key: key);

  final Product product;
  final int currentVarient;

  @override
  _ProductImagesState createState() =>
      _ProductImagesState(currentVarient: currentVarient);
}

class _ProductImagesState extends State<ProductImages> {
  final int currentVarient;

  _ProductImagesState({
    @required this.currentVarient,
  });

  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
                tag: widget.product.id.toString(),
                child: InteractiveViewer(
                  child: Image.asset(widget
                      .product.varients[currentVarient].images[selectedImage]),
                )),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
                widget.product.varients[currentVarient].images.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child:
            Image.asset(widget.product.varients[currentVarient].images[index]),
      ),
    );
  }
}
