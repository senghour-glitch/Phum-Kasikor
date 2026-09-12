import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/color/color.dart';
import 'package:phum_kasikor/widgets/farmer/farmer_bottom_nav.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Phum Kasikor',

      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: FarmerBottomNav(),

      // First screen
      initialRoute: AppRoutes.signup,

      // GetX routes
      getPages: AppPages.routes,
    );
  }
}
