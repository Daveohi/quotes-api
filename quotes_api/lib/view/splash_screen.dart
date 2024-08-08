import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:quotes/view/login_screen.dart';
// import 'package:quotes/view/signup_screen.dart';

import '../utils/colors.dart';
import '../widget/custom_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Flexible(child: Image.asset('assets/images/pencil_tree.png')),
          const Text(
            'Quotes',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          // Image.asset(
          //   'assets/images/logo_row.png',
          //   width: 104.w,
          // ),
          SizedBox(
            height: 7.h,
          ),
          Container(
            height: 240.h,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(13.r),
                  topLeft: Radius.circular(13.r),
                ),
                color: kGrey),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Special Quotes from dummyData json',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 21.h,
                ),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: () {
                    // Get.offAll(() => const Signup());
                  },
                  width: 167.w,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    // Get.offAll(() => SignIn());
                  },
                  fillColor: kGrey,
                  textColor: Colors.black,
                  width: 167.w,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
