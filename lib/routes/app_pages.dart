import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../view/Auth/choose_role_screen.dart';
import '../view/Auth/location_screen.dart';
import '../view/Auth/login_screen.dart';
import '../view/Auth/onboarding.dart';
import '../view/Auth/otp_screen.dart';
import '../view/Auth/profile_setup_screen.dart';
import '../view/Auth/sin_up_screen.dart';
import '../view/Auth/splash_screen.dart';
import '../view/Auth/welcome_screen.dart';

abstract final class AppPages {
  static const splash = '/';

  static final pages = <GetPage<dynamic>>[
    GetPage(name: splash, page: SplashScreen.new),
    GetPage(name: '/onboarding', page: Onboarding.new),
    GetPage(name: '/welcome', page: WelcomeScreen.new),
    GetPage(name: '/login', page: LoginScreen.new),
    GetPage(name: '/sign-up', page: SinUpScreen.new),
    GetPage(name: '/otp', page: OtpScreen.new, binding: AuthBinding()),
    GetPage(name: '/choose-role', page: ChooseRoleScreen.new, binding: AuthBinding()),
    GetPage(name: '/profile-setup', page: ProfileSetupScreen.new, binding: AuthBinding()),
    GetPage(name: '/location', page: LocationScreen.new, binding: AuthBinding()),
  ];
}

class AuthBinding extends Bindings {
  @override
  void dependencies() => Get.put(AuthController(), permanent: true);
}
