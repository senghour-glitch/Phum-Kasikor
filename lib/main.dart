import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/color/color.dart';
import 'package:phum_kasikor/core/routes/app_routes.dart';
<<<<<<< HEAD
import 'package:phum_kasikor/firebase_options.dart';
import 'package:phum_kasikor/core/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
=======
import 'package:phum_kasikor/core/routes/route_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 
>>>>>>> 29f5c6a (Update customer features)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      title: 'Phum Kasikor',
      theme: AppTheme.light,
      // First screen
      initialRoute: AppRoutes.splash,
      // GetX routes
      getPages: AppPages.routes,
=======
      theme: AppTheme.light,
      initialRoute: AppRoutes.signup,
      onGenerateRoute:
          RouteGenerator.generateRoute,
>>>>>>> 29f5c6a (Update customer features)
    );
  }
}