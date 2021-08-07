import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orev/models/Product.dart';
import 'package:orev/models/Varient.dart';

class ProductServices {
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');
  DocumentReference mainscreen = FirebaseFirestore.instance
      .collection('mainscreen')
      .doc("FPqix1bIAibs46FOA5zV");
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  CollectionReference favourites =
      FirebaseFirestore.instance.collection('favourites');

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<Product> getProduct(productId) async {
    ProductServices _services = ProductServices();
    var document = await _services.products.doc(productId).get();
    print(document.exists);
    var listVarientraw = document["variant"];
    print(listVarientraw);
    List<Varient> listVarient = [];
    for (var vari in listVarientraw) {
      print(vari["variantDetails"]["title"]);
      print(vari["variantDetails"]["title"]);
      listVarient.add(new Varient(
          default_product: vari["default"],
          isOnSale: vari["onSale"]["isOnSale"],
          comparedPrice: vari["onSale"]["comparedPrice"].toDouble(),
          discountPercentage: vari["onSale"]["discountPercentage"].toDouble(),
          price: vari["price"].toDouble(),
          inStock: vari["stock"]["inStock"],
          qty: vari["stock"]["qty"],
          title: vari["variantDetails"]["title"],
          images: vari["variantDetails"]["images"]));
    }
    return Product(
        id: document["productId"],
        brandname: document["brand"],
        varients: listVarient,
        title: document["title"],
        detail: document["detail"],
        rating: document["rating"],
        isFavourite: true,
        isPopular: true,
        tax: document["tax"].toDouble(),
        youmayalsolike: document["youMayAlsoLike"]);
  }
}
