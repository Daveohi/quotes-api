import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../utils/colors.dart';
import 'profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48.h,
        backgroundColor: kGrey,
        title: const Text(
          'Quotes',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const ProfileScreen());
            },
            child: Image.asset(
              'assets/icons/person.png',
              width: 20.w,
            ),
          ),
          SizedBox(
            width: 18.w,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
