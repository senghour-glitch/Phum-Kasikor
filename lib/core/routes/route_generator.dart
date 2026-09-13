import 'package:flutter/material.dart';
import 'package:phum_kasikor/view/Auth/choose_role_screen.dart';
import 'package:phum_kasikor/view/Auth/login_screen.dart';
import 'package:phum_kasikor/view/Auth/onboarding_screen.dart';
import 'package:phum_kasikor/view/Auth/otp_screen.dart';
import 'package:phum_kasikor/view/Auth/sigup_screen.dart';
import 'package:phum_kasikor/view/Auth/splash_screen.dart';
import 'package:phum_kasikor/view/Customer/customer_cart_screen.dart';
import 'package:phum_kasikor/view/Customer/customer_checkout_screen.dart';
import 'package:phum_kasikor/view/Customer/customer_explore_screen.dart';
import 'package:phum_kasikor/view/Customer/customer_farm_deteil_screen.dart';
import 'package:phum_kasikor/view/Customer/customer_farm_map_screen.dart';
import 'package:phum_kasikor/view/Customer/customer_farm_products_screen.dart';
import 'package:phum_kasikor/view/Customer/customer_home_screen.dart';
import 'package:phum_kasikor/view/Customer/customer_order_success_screen.dart';
import 'package:phum_kasikor/view/Customer/customer_order_tracking_screen.dart';
import 'package:phum_kasikor/view/Customer/customer_payment_screen.dart';
import 'package:phum_kasikor/view/Customer/customer_product_deteil_screen.dart';
import 'package:phum_kasikor/view/Customer/customer_profile_screen.dart';
import 'package:phum_kasikor/view/Customer/customer_search_filter_screen.dart';
import 'package:phum_kasikor/view/Farmer/farmer_add_crop_screen.dart';
import 'package:phum_kasikor/view/Farmer/farmer_add_product_screen.dart';
import 'package:phum_kasikor/view/Farmer/farmer_crop_detail_screen.dart';
import 'package:phum_kasikor/view/Farmer/farmer_crops_screen.dart';
import 'package:phum_kasikor/view/Farmer/farmer_earnings_screen.dart';
import 'package:phum_kasikor/view/Farmer/farmer_farm_profile.dart';
import 'package:phum_kasikor/view/Farmer/farmer_home_screen.dart';
import 'package:phum_kasikor/view/Farmer/farmer_my_farm.dart';
import 'package:phum_kasikor/view/Farmer/farmer_order_detail_screen.dart';
import 'package:phum_kasikor/view/Farmer/farmer_orders_screen.dart';
import 'package:phum_kasikor/view/Farmer/farmer_product_preview_screen.dart';
import 'package:phum_kasikor/view/Farmer/farmer_products_screen.dart';
import 'package:phum_kasikor/view/Farmer/farmer_profile_screen.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // =========================
      // PUBLIC / AUTH
      // =========================

      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SigupScreen());

      case AppRoutes.roleSelection:
        return MaterialPageRoute(builder: (_) => const ChooseRoleScreen());

      case AppRoutes.verification:
        return MaterialPageRoute(builder: (_) => const OtpScreen());

      case AppRoutes.customerHome:
        return MaterialPageRoute(builder: (_) => const CustomerHomeScreen());

      case AppRoutes.customerExplore:
        return MaterialPageRoute(builder: (_) => const CustomerExploreScreen());

      case AppRoutes.customerSearchFilter:
        return MaterialPageRoute(
          builder: (_) => const CustomerSearchFilterScreen(),
        );

      case AppRoutes.customerProductDetail:
        return MaterialPageRoute(
          builder: (_) => const CustomerProductDeteilScreen(),
        );

      case AppRoutes.customerCart:
        return MaterialPageRoute(builder: (_) => const CustomerCartScreen());

      case AppRoutes.customerCheckout:
        return MaterialPageRoute(
          builder: (_) => const CustomerCheckoutScreen(),
        );

      case AppRoutes.customerPayment:
        return MaterialPageRoute(builder: (_) => const CustomerPaymentScreen());

      case AppRoutes.customerOrderSuccess:
        return MaterialPageRoute(
          builder: (_) => const CustomerOrderSuccessScreen(),
        );

      case AppRoutes.customerOrderTracking:
        return MaterialPageRoute(
          builder: (_) => const CustomerOrderTrackingScreen(),
        );

      case AppRoutes.customerFarmDetail:
        return MaterialPageRoute(
          builder: (_) => const CustomerFarmDeteilScreen(),
        );

      case AppRoutes.customerFarmMap:
        return MaterialPageRoute(builder: (_) => const CustomerFarmMapScreen());

      case AppRoutes.customerFarmProducts:
        return MaterialPageRoute(
          builder: (_) => const CustomerFarmProductsScreen(),
        );

      case AppRoutes.customerProfile:
        return MaterialPageRoute(builder: (_) => const CustomerProfileScreen());

      // =========================
      // FARMER
      // =========================

      case AppRoutes.farmerHome:
        return MaterialPageRoute(builder: (_) => const FarmerHomeScreen());

      case AppRoutes.farmerProducts:
        return MaterialPageRoute(builder: (_) => const FarmerProductsScreen());

      case AppRoutes.farmerAddProduct:
        return MaterialPageRoute(
          builder: (_) => const FarmerAddProductScreen(),
        );

      case AppRoutes.farmerProductPreview:
        return MaterialPageRoute(
          builder: (_) => const FarmerProductPreviewScreen(),
        );

      case AppRoutes.farmerCrops:
        return MaterialPageRoute(builder: (_) => const FarmerCropsScreen());

      case AppRoutes.farmerAddCrop:
        return MaterialPageRoute(builder: (_) => const FarmerAddCropScreen());

      case AppRoutes.farmerCropDetail:
        return MaterialPageRoute(
          builder: (_) => const FarmerCropDetailScreen(),
        );

      case AppRoutes.farmerEarnings:
        return MaterialPageRoute(builder: (_) => const FarmerEarningsScreen());

      case AppRoutes.farmerFarmProfile:
        return MaterialPageRoute(builder: (_) => const FarmerFarmProfile());

      case AppRoutes.farmerMyFarm:
        return MaterialPageRoute(builder: (_) => const FarmerMyFarm());

      case AppRoutes.farmerOrders:
        return MaterialPageRoute(builder: (_) => const FarmerOrdersScreen());

      case AppRoutes.farmerOrderDetail:
        return MaterialPageRoute(
          builder: (_) => const FarmerOrderDetailScreen(),
        );

      case AppRoutes.farmerProfile:
        return MaterialPageRoute(builder: (_) => const FarmerProfileScreen());

      // =========================
      // UNKNOWN ROUTE
      // =========================

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route not found: ${settings.name}')),
          ),
        );
    }
  }
}
