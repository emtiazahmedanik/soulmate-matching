import 'package:elias_creed/feature/auth/forget_pass/screen/forget_pass_screen.dart';
import 'package:elias_creed/feature/auth/forget_pass/screen/new_pass_screen.dart';
import 'package:elias_creed/feature/auth/login/view/login_view.dart';
import 'package:elias_creed/feature/auth/signup/profile_flow/view/name_screen.dart';
import 'package:elias_creed/feature/auth/signup/register/view/register_view.dart';
import 'package:elias_creed/feature/auth/signup/register/view/verify_otp_screen.dart';
import 'package:elias_creed/feature/bottom_navbar/view/bottom_navbar_view.dart';
import 'package:elias_creed/feature/message/screen/message_screen.dart';
import 'package:elias_creed/feature/onboarding/view/onboarding_screen.dart';
import 'package:elias_creed/feature/splash_screen/screen/splash_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static String splashScreen = '/splashScreen';
  static String onboardingScreen = '/onboardingScreen';
  static String loginView = '/loginView';
  static String registerView = '/registerView';
  static String nameScreen = '/nameScreen';
  static String bottomNavbarScreen = '/bottomNavbarScreen';
  static String forgetPassScreen = '/forgetPassScreen';
  static String newPassScreen = '/newPassScreen';
  static String verifyOtpScreen = '/verifyOtpScreen';
  static String messageScreen = '/messageScreen';


  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;
  static String getLoginView() => loginView;
  static String getRegisterView() => registerView;
  static String getNameScreen() => nameScreen;
  static String getBottomNavbarScreen() => bottomNavbarScreen;
  static String getForgetPassScreen() => forgetPassScreen;
  static String getNewPassScreen() => newPassScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: loginView, page: () => LoginView()),
    GetPage(name: registerView, page: () => RegisterView()),
    GetPage(name: nameScreen, page: () => NameScreen()),
    GetPage(name: bottomNavbarScreen, page: () => BottomNavbarView()),
    GetPage(name: forgetPassScreen, page: () => ForgetPassScreen()),
    GetPage(name: newPassScreen, page: () => NewPassScreen()),
    GetPage(name: verifyOtpScreen, page: () => VerifyOtpScreen()),
    GetPage(name: messageScreen, page: () => MessageScreen()),

  ];
}
