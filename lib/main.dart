import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:price_check_np/models/filter_provider.dart';
import 'package:price_check_np/routing/app_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => FilterProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routeInformationParser: AppRouter.router.routeInformationParser,
      theme: ThemeData(
        primaryColorLight: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        primaryColorDark: Colors.black,
        indicatorColor: const Color.fromRGBO(93, 88, 88, 1.0),
      ),
    );
  }
}
