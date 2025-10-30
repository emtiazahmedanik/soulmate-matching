import 'package:elias_creed/firebase_options.dart';
import 'package:elias_creed/route/app_route.dart';
import 'package:elias_creed/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show ScreenUtilInit;
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configEasyLoading();
  runApp(MyApp());
}

void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.black
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..maskColor = Colors.green
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  @override
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Anuchem',
        getPages: AppRoute.routes,
        initialRoute: AppRoute.splashScreen,
        builder: EasyLoading.init(),
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
