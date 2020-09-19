class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRODUCT_ID = "productId";
  static const QUANTITY = "quantity";
  static const PRICE = "price";
  static const SHOP_ID = "shopId";
  static const TOTAL_SHOP_SALES = "totalShopSale";

  String _id;
  String _name;
  String _image;
  String _productId;
  String _shopId;
  int _totalShopSale;
  int _quantity;
  int _price;

  //  getters
  String get id => _id;

  String get name => _name;

  String get image => _image;

  String get productId => _productId;

  String get shopId => _shopId;

  int get price => _price;

  int get totalShopSale => _totalShopSale;

  int get quantity => _quantity;

  CartItemModel.fromMap(Map data) {
    _id = data[ID];
    _name = data[NAME];
    _image = data[IMAGE];
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
    _totalShopSale = data[TOTAL_SHOP_SALES];
    _shopId = data[SHOP_ID];
  }

  Map toMap() => {
        ID: _id,
        IMAGE: _image,
        NAME: _name,
        PRODUCT_ID: _productId,
        QUANTITY: _quantity,
        PRICE: _price,
        SHOP_ID: _shopId,
        TOTAL_SHOP_SALES: _totalShopSale
      };
}
