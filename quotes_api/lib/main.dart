// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'controller/auth_controller.dart';
import 'utils/colors.dart';
import 'view/splash_screen.dart';

void main() async {
  // Get.put(SignupController());
  runApp(const ApiQuotes());
}

class ApiQuotes extends StatelessWidget {
  const ApiQuotes({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (_, child) {
          return GetMaterialApp(
            title: 'API Quotes',
            theme: ThemeData(colorSchemeSeed: kPrimary),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        });
  }
}
