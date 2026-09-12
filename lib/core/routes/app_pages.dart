import 'package:get/get.dart';

// Auth
import 'package:phum_kasikor/view/Auth/choose_role_screen.dart';
import 'package:phum_kasikor/view/Auth/login_screen.dart';
import 'package:phum_kasikor/view/Auth/onboarding_screen.dart';
import 'package:phum_kasikor/view/Auth/otp_screen.dart';
import 'package:phum_kasikor/view/Auth/sigup_screen.dart';
import 'package:phum_kasikor/view/Auth/splash_screen.dart';

// Customer
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

// Farmer
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

class AppPages {
  static final List<GetPage> routes = [
    // ==================== AUTH ====================

    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),

    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),

    GetPage(
      name: AppRoutes.signup,
      page: () => const SigupScreen(),
    ),

    GetPage(
      name: AppRoutes.roleSelection,
      page: () => const ChooseRoleScreen(),
    ),

    GetPage(
      name: AppRoutes.verification,
      page: () => const OtpScreen(),
    ),

    // ==================== CUSTOMER ====================

    GetPage(
      name: AppRoutes.customerHome,
      page: () => const CustomerHomeScreen(),
    ),

    GetPage(
      name: AppRoutes.customerExplore,
      page: () => const CustomerExploreScreen(),
    ),

    GetPage(
      name: AppRoutes.customerSearchFilter,
      page: () => const CustomerSearchFilterScreen(),
    ),

    GetPage(
      name: AppRoutes.customerProductDetail,
      page: () => const CustomerProductDeteilScreen(),
    ),

    GetPage(
      name: AppRoutes.customerCart,
      page: () => const CustomerCartScreen(),
    ),

    GetPage(
      name: AppRoutes.customerCheckout,
      page: () => const CustomerCheckoutScreen(),
    ),

    GetPage(
      name: AppRoutes.customerPayment,
      page: () => const CustomerPaymentScreen(),
    ),

    GetPage(
      name: AppRoutes.customerOrderSuccess,
      page: () => const CustomerOrderSuccessScreen(),
    ),

    GetPage(
      name: AppRoutes.customerOrderTracking,
      page: () => const CustomerOrderTrackingScreen(),
    ),

    GetPage(
      name: AppRoutes.customerFarmDetail,
      page: () => const CustomerFarmDeteilScreen(),
    ),

    GetPage(
      name: AppRoutes.customerFarmMap,
      page: () => const CustomerFarmMapScreen(),
    ),

    GetPage(
      name: AppRoutes.customerFarmProducts,
      page: () => const CustomerFarmProductsScreen(),
    ),

    GetPage(
      name: AppRoutes.customerProfile,
      page: () => const CustomerProfileScreen(),
    ),

    // ==================== FARMER ====================

    GetPage(
      name: AppRoutes.farmerHome,
      page: () => const FarmerHomeScreen(),
    ),

    GetPage(
      name: AppRoutes.farmerProducts,
      page: () => const FarmerProductsScreen(),
    ),

    GetPage(
      name: AppRoutes.farmerAddProduct,
      page: () => const FarmerAddProductScreen(),
    ),

    GetPage(
      name: AppRoutes.farmerProductPreview,
      page: () => const FarmerProductPreviewScreen(),
    ),

    GetPage(
      name: AppRoutes.farmerCrops,
      page: () => const FarmerCropsScreen(),
    ),

    GetPage(
      name: AppRoutes.farmerAddCrop,
      page: () => const FarmerAddCropScreen(),
    ),

    GetPage(
      name: AppRoutes.farmerCropDetail,
      page: () => const FarmerCropDetailScreen(),
    ),

    GetPage(
      name: AppRoutes.farmerEarnings,
      page: () => const FarmerEarningsScreen(),
    ),

    GetPage(
      name: AppRoutes.farmerFarmProfile,
      page: () => const FarmerFarmProfile(),
    ),

    GetPage(
      name: AppRoutes.farmerMyFarm,
      page: () => const FarmerMyFarm(),
    ),

    GetPage(
      name: AppRoutes.farmerOrders,
      page: () => const FarmerOrdersScreen(),
    ),

    GetPage(
      name: AppRoutes.farmerOrderDetail,
      page: () => const FarmerOrderDetailScreen(),
    ),

    GetPage(
      name: AppRoutes.farmerProfile,
      page: () => const FarmerProfileScreen(),
    ),
  ];
}