import 'package:flutter/material.dart';
import 'package:digitalsaloon/scr/providers/app.dart';
import 'package:digitalsaloon/scr/providers/category.dart';
import 'package:digitalsaloon/scr/providers/product.dart';
import 'package:digitalsaloon/scr/providers/shop.dart';
import 'package:digitalsaloon/scr/providers/user.dart';
import 'package:digitalsaloon/scr/screens/home.dart';
import 'package:digitalsaloon/scr/screens/login.dart';
import 'package:digitalsaloon/scr/screens/splash.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: ShopProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DigitalSaloon',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ScreensController())));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default:
        return LoginScreen();
    }
  }
}
