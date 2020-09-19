import 'package:flutter/material.dart';
import 'package:digitalsaloon/scr/helpers/screen_navigation.dart';
import 'package:digitalsaloon/scr/helpers/style.dart';
import 'package:digitalsaloon/scr/providers/app.dart';
import 'package:digitalsaloon/scr/providers/product.dart';
import 'package:digitalsaloon/scr/providers/shop.dart';
import 'package:digitalsaloon/scr/screens/shop.dart';
import 'package:digitalsaloon/scr/widgets/custom_text.dart';
import 'package:digitalsaloon/scr/widgets/loading.dart';
import 'package:digitalsaloon/scr/widgets/shop.dart';
import 'package:provider/provider.dart';

class ShopsSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: CustomText(
          text: "Shops",
          size: 20,
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : shopProvider.searchedShops.length < 1
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: grey,
                          size: 30,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: "No Shops Found",
                          color: grey,
                          weight: FontWeight.w300,
                          size: 22,
                        ),
                      ],
                    )
                  ],
                )
              : ListView.builder(
                  itemCount: shopProvider.searchedShops.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () async {
                          app.changeLoading();
                          await productProvider.loadProductsByShop(
                              shopId: shopProvider.searchedShops[index].id);
                          app.changeLoading();

                          changeScreen(
                              context,
                              ShopScreen(
                                shopModel: shopProvider.searchedShops[index],
                              ));
                        },
                        child: ShopWidget(
                            shop: shopProvider.searchedShops[index]));
                  }),
    );
  }
}
