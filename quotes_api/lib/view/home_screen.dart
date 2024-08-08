import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../utils/colors.dart';
import '../widget/custom_button.dart';
import 'profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48.h,
        backgroundColor: kGrey,
        title: const Text(
          'SketchIt',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => ProfileScreen());
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
          children: [
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                String? projName;
                Get.dialog(AlertDialog(
                  title: Text(
                    'Enter Project Name',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  content: TextField(
                    onChanged: (v) => projName = v,
                  ),
                  // actions: [
                  //   CustomButton(
                  //     onPressed: () {
                  //       if (projName == null) {
                  //         Get.snackbar('Project Creation Failed',
                  //             'You have to enter a project name');
                  //         return;
                  //       }
                  //       Get.off(() => EditingScreen(
                  //             projName: projName!,
                  //           ));
                  //     },
                  //     text: 'Continue',
                  //   ),
                  //   SizedBox(
                  //     height: 10.h,
                  //   ),
                  //   CustomButton(
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     },
                  //     text: 'Cancel',
                  //     filled: false,
                  //     textColor: Colors.black,
                  //   ),
                  // ],
                ));
              },
              // child: Container(
              //   width: 100.w,
              //   height: 85.h,
              //   decoration: BoxDecoration(
              //       color: kGrey1,
              //       boxShadow: [
              //         BoxShadow(
              //             blurRadius: 1.8,
              //             color: Colors.black.withOpacity(0.25))
              //       ],
              //       borderRadius: BorderRadius.circular(6.r)),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Image.asset(
              //         'assets/icons/add.png',
              //         width: 27.w,
              //       ),
              //       SizedBox(
              //         height: 8.h,
              //       ),
              //       Text(
              //         'Create New',
              //         style: TextStyle(
              //             fontSize: 8.sp, fontWeight: FontWeight.w500),
              //       )
              //     ],
              //   ),
              // ),
            ),
            // SizedBox(
            //   height: 24.h,
            // ),
            // Text(
            //   'Saved Works',
            //   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
            // ),
          ],
        ),
      ),
    );
  }
}
