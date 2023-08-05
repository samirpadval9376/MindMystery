import 'package:drag_drop/controllers/animal_controller.dart';
import 'package:drag_drop/controllers/fruit_controller.dart';
import 'package:drag_drop/utils/my_page_route_utils.dart';
import 'package:drag_drop/views/screens/animal_page.dart';
import 'package:drag_drop/views/screens/fruit_page.dart';
import 'package:drag_drop/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AnimalController(),
        ),
        ChangeNotifierProvider(
          create: (context) => FruitController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      routes: {
        MyPageRoute.home: (context) => HomePage(),
        MyPageRoute.buildOptions[0].route: (context) => const AnimalPage(),
        MyPageRoute.buildOptions[1].route: (context) => const FruitPage(),
      },
    );
  }
}
