import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:digitalsaloon/scr/helpers/screen_navigation.dart';
import 'package:digitalsaloon/scr/helpers/style.dart';
import 'package:digitalsaloon/scr/providers/app.dart';
import 'package:digitalsaloon/scr/providers/category.dart';
import 'package:digitalsaloon/scr/providers/product.dart';
import 'package:digitalsaloon/scr/providers/shop.dart';
import 'package:digitalsaloon/scr/providers/user.dart';
import 'package:digitalsaloon/scr/screens/cart.dart';
import 'package:digitalsaloon/scr/screens/category.dart';
import 'package:digitalsaloon/scr/screens/login.dart';
import 'package:digitalsaloon/scr/screens/order.dart';
import 'package:digitalsaloon/scr/screens/product_search.dart';
import 'package:digitalsaloon/scr/screens/shop.dart';
import 'package:digitalsaloon/scr/screens/shops_search.dart';
import 'package:digitalsaloon/scr/widgets/categories.dart';
import 'package:digitalsaloon/scr/widgets/custom_text.dart';
import 'package:digitalsaloon/scr/widgets/featured_products.dart';
import 'package:digitalsaloon/scr/widgets/loading.dart';
import 'package:digitalsaloon/scr/widgets/shop.dart';
import 'package:provider/provider.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final shopProvider = Provider.of<ShopProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    shopProvider.loadSingleShop();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "DigitalSaloon",
          color: white,
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  changeScreen(context, CartScreen());
                },
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primary),
              accountName: CustomText(
                text: user.userModel?.name ?? "afsvbdvSdbsxdb",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: user.userModel?.email ?? "",
                color: white,
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, Home());
              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),
            ListTile(
              onTap: () async {
                await user.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My orders"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, CartScreen());
              },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart"),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Language'),
                leading: Icon(Icons.language),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Rate Card'),
                leading: Icon(Icons.credit_card),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Terms of Use'),
                leading: Icon(Icons.texture),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Support'),
                leading: Icon(Icons.call),
              ),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out"),
            ),
            Center(
              child: Text('App Version'),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : SafeArea(
              child: ListView(
                children: <Widget>[
                  ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 250.0,
                      padding: EdgeInsets.only(bottom: 50.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        image: DecorationImage(
                          image: AssetImage("assets/9.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              "Find saloons & Book Appointment Near you",
                              style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            width: double.infinity,
                            height: 50.0,
                            margin: EdgeInsets.symmetric(horizontal: 18.0),
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white.withOpacity(.9),
                            ),
                            child: TextField(
                              cursorColor: Colors.black,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (pattern) async {
                                app.changeLoading();
                                if (app.search == SearchBy.PRODUCTS) {
                                  await productProvider.search(
                                      productName: pattern);
                                  changeScreen(context, ProductSearchScreen());
                                } else {
                                  await shopProvider.search(name: pattern);
                                  changeScreen(context, ShopsSearchScreen());
                                }
                                app.changeLoading();
                              },
                              decoration: InputDecoration(
                                hintText: "Search Saloon, Spa and Barber",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CustomText(
                        text: "Search by:",
                        color: grey,
                        weight: FontWeight.w300,
                      ),
                      DropdownButton<String>(
                        value: app.filterBy,
                        style: TextStyle(
                            color: primary, fontWeight: FontWeight.w300),
                        icon: Icon(
                          Icons.filter_list,
                          color: primary,
                        ),
                        elevation: 0,
                        onChanged: (value) {
                          if (value == "Products") {
                            app.changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                          } else {
                            app.changeSearchBy(newSearchBy: SearchBy.SHOPS);
                          }
                        },
                        items: <String>["Products", "Shops"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryProvider.categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
//                              app.changeLoading();
                              await productProvider.loadProductsByCategory(
                                  categoryName:
                                      categoryProvider.categories[index].name);

                              changeScreen(
                                  context,
                                  CategoryScreen(
                                    categoryModel:
                                        categoryProvider.categories[index],
                                  ));

//                              app.changeLoading();
                            },
                            child: CategoryWidget(
                              category: categoryProvider.categories[index],
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: "Featured",
                          size: 20,
                          color: grey,
                        ),
                      ],
                    ),
                  ),
                  Featured(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: "Popular shops",
                          size: 20,
                          color: grey,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: shopProvider.shops
                        .map((item) => GestureDetector(
                              onTap: () async {
                                app.changeLoading();

                                await productProvider.loadProductsByShop(
                                    shopId: item.id);
                                app.changeLoading();

                                changeScreen(
                                    context,
                                    ShopScreen(
                                      shopModel: item,
                                    ));
                              },
                              child: ShopWidget(
                                shop: item,
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
    );
  }
}
