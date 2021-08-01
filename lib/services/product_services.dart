import 'package:cloud_firestore/cloud_firestore.dart';

class ProductServices {
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');
  DocumentReference mainscreen = FirebaseFirestore.instance
      .collection('mainscreen')
      .doc("FPqix1bIAibs46FOA5zV");
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
}
