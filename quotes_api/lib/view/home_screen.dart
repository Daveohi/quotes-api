import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quotes_api/controller.dart/homecontroller.dart';

import '../utils/colors.dart';
import 'profile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

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
