import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/shop.dart';

class ShopServices {
  String collection = "shops";
  Firestore _firestore = Firestore.instance;

  Future<List<ShopModel>> getShops() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<ShopModel> shops = [];
        for (DocumentSnapshot shop in result.documents) {
          shops.add(ShopModel.fromSnapshot(shop));
        }
        return shops;
      });

  Future<ShopModel> getShopById({String id}) => _firestore
          .collection(collection)
          .document(id.toString())
          .get()
          .then((doc) {
        return ShopModel.fromSnapshot(doc);
      });

  Future<List<ShopModel>> searchShop({String shopName}) {
    // code to convert the first character to uppercase
    String searchKey = shopName[0].toUpperCase() + shopName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
          List<ShopModel> shops = [];
          for (DocumentSnapshot product in result.documents) {
            shops.add(ShopModel.fromSnapshot(product));
          }
          return shops;
        });
  }
}
