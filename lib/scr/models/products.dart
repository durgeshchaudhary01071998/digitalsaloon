import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const RATING = "rating";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const SHOP_ID = "shopId";
  static const SHOP = "shop";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const RATES = "rates";
  static const USER_LIKES = "userLikes";

  String _id;
  String _name;
  String _shopId;
  String _shop;
  String _category;
  String _image;
  String _description;

  double _rating;
  int _price;
  int _rates;

  bool _featured;

  String get id => _id;

  String get name => _name;

  String get shop => _shop;

  String get shopId => _shopId;

  String get category => _category;

  String get description => _description;

  String get image => _image;

  double get rating => _rating;

  int get price => _price;

  bool get featured => _featured;

  int get rates => _rates;

  // public variable
  bool liked = false;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _image = snapshot.data[IMAGE];
    _shop = snapshot.data[SHOP];
    _shopId = snapshot.data[SHOP_ID].toString();
    _description = snapshot.data[DESCRIPTION];
    _id = snapshot.data[ID];
    _featured = snapshot.data[FEATURED];
    _price = snapshot.data[PRICE].floor();
    _category = snapshot.data[CATEGORY];
    _rating = snapshot.data[RATING];
    _rates = snapshot.data[RATES];
    _name = snapshot.data[NAME];
  }
}
