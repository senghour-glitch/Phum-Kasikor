import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/color/color.dart';
<<<<<<< HEAD
import 'package:phum_kasikor/widgets/farmer/farmer_bottom_nav.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
=======
import 'package:phum_kasikor/core/routes/app_routes.dart';
import 'package:phum_kasikor/core/routes/route_generator.dart';
import 'package:phum_kasikor/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 
>>>>>>> 4378a247e554c8536c582b7bc00fcb67f387ba60
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: FarmerBottomNav(),
=======
      theme: AppTheme.light,
      initialRoute: AppRoutes.onboarding,

      onGenerateRoute:
          RouteGenerator.generateRoute,
>>>>>>> 4378a247e554c8536c582b7bc00fcb67f387ba60
    );
  }
}
