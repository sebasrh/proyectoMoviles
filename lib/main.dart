// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerooms/providers/place_provider.dart';
import 'package:seerooms/services/services.dart';
import 'page/page.dart';

void main() async {
  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => PlaceService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SeeRooms',
        initialRoute: 'login_page',
        routes: {
          'login_page': (BuildContext context) => LoginPage(),
          'register_page': (BuildContext context) => RegisterPage(),
          'home_page': (BuildContext context) => HomePage(),
          'place_page': (BuildContext context) => PlacePage(),
        });
  }
}
