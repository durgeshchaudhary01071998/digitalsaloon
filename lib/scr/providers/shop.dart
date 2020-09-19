import 'package:flutter/material.dart';
import '../helpers/shop.dart';
import '../models/shop.dart';

class ShopProvider with ChangeNotifier {
  ShopServices _shopServices = ShopServices();
  List<ShopModel> shops = [];
  List<ShopModel> searchedShops = [];

  ShopModel shop;

  ShopProvider.initialize() {
    loadShops();
  }

  loadShops() async {
    shops = await _shopServices.getShops();
    notifyListeners();
  }

  loadSingleShop({String shopId}) async {
    shop = await _shopServices.getShopById(id: shopId);
    notifyListeners();
  }

  Future search({String name}) async {
    searchedShops = await _shopServices.searchShop(shopName: name);
    print("SHOPS ARE: ${searchedShops.length}");
    notifyListeners();
  }
}
