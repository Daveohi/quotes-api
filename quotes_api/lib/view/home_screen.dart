import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quotes_api/controller.dart/homecontroller.dart';

import '../utils/colors.dart';
import 'profile_Screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGrey,
        title: const Text(
          'QUOTES',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.w),
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 104.w, bottom: 10.h),
            child: TextField(
              onChanged: (value) => controller.searchQuotes(value),
              decoration: InputDecoration(
                hintText: 'Search for quotes...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: kGrey1,
              ),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const ProfileScreen());
            },
            child: Row(
              children: [
                Text(
                  'Profile  ',
                  style: TextStyle(fontSize: 18.w),
                ),
                Image.asset(
                  'assets/icons/person.png',
                  width: 20.w,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 18.w,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.quotes.isEmpty) {
          return const Center(child: Text('No quotes found.'));
        } else {
          return ListView.builder(
            itemCount: controller.quotes.length,
            itemBuilder: (context, index) {
              var quote = controller.quotes[index];
              return ListTile(
                title: Text(quote.quote),
                subtitle: Text('- ${quote.author}'),
              );
            },
          );
        }
      }),
    );
  }
}
