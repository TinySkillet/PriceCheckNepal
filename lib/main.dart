import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:price_check_np/models/filter_provider.dart';
import 'package:price_check_np/routing/app_router.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Request necessary permissions before running the app
  await _requestPermissions();

  runApp(
    ChangeNotifierProvider(
      create: (context) => FilterProvider(),
      child: const MyApp(),
    ),
  );
}

Future<void> _requestPermissions() async {
  // check storage perms
  var storageStatus = await Permission.storage.status;
  // if not granted, request for perms
  if (!storageStatus.isGranted) {
    storageStatus = await Permission.storage.request();
  }
  if (!storageStatus.isGranted) {
    log('Storage permission was denied');
  }
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
