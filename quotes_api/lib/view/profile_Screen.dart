import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quotes_api/utils/colors.dart';
import 'package:quotes_api/view/login_screen.dart';
import 'package:quotes_api/widget/custom_button.dart';
import '../controller.dart/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _switchValue = false;
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // File? _image;
  final ImagePicker _picker = ImagePicker();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final user = _authController.auth.currentUser;
    _nameController.text = user?.displayName ?? '';
    _phoneController.text = user?.phoneNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final user = _authController.auth.currentUser;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        try {
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (image == null) {
                            Get.snackbar('Cancelled', 'No image selected',
                                snackPosition: SnackPosition.TOP);
                            return;
                          }
                          Get.put(AuthController())
                              .updateImage(File(image.path));
                          Get.snackbar('Image Selected',
                              'Your profile image has been updated.',
                              snackPosition: SnackPosition.TOP);
                        } catch (e) {
                          Get.snackbar('Error', 'Failed to pick image: $e',
                              snackPosition: SnackPosition.TOP);
                          print('Error picking image: $e');
                        }
                      },
                      child: Obx(() {
                        final imageFile = Get.put(AuthController()).imageFile;
                        return CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 60.h,
                          backgroundImage:
                              imageFile != null ? FileImage(imageFile) : null,
                          child: imageFile == null
                              ? Icon(
                                  Icons.person,
                                  size: 80.h,
                                )
                              : null,
                        );
                      }),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    if (_isEditing)
                      Column(
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                          ),
                          SizedBox(height: 10.h),
                          CustomButton(
                            width: 80.w,
                            height: 30.h,
                            onPressed: () async {
                              await _saveProfile();
                              setState(() {
                                _isEditing = false;
                              });
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(color: kwhite),
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          Text(
                            user?.displayName ?? 'Name',
                            style: TextStyle(fontSize: 12.h),
                          ),
                          Text(
                            user?.email ?? 'Email',
                            style: TextStyle(fontSize: 12.h),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10.h),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.h, vertical: 14.h),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isEditing = true;
                                  });
                                },
                                child: const Text(
                                  'Edit Profile',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Divider(
                thickness: 1.h,
                color: Colors.black,
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Account Created',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.h),
              ),
              Text(
                'Date: ${user?.metadata.creationTime?.toString() ?? ''}',
                style: TextStyle(color: kwhite, fontSize: 15.h),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Share ',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.h),
              ),
              Text(
                'Share the app  with friends',
                style: TextStyle(color: kwhite, fontSize: 15.h),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auto Update',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20.h),
                      ),
                      Text(
                        'Toggle the switch to\nauto update the app or not. ',
                        style: TextStyle(color: kwhite, fontSize: 15.h),
                      ),
                    ],
                  ),
                  CupertinoSwitch(
                    activeColor: kblack,
                    trackColor: Colors.grey,
                    value: _switchValue,
                    onChanged: (bool value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Premium',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.h),
              ),
              Text(
                'You can choose our paid plans\nto enjoy more benefits. ',
                style: TextStyle(color: kwhite, fontSize: 15.h),
              ),
              SizedBox(
                height: 25.h,
              ),
              Center(
                child: CustomButton(
                  width: 80.w,
                  onPressed: () async {
                    await _authController.logout();
                    Get.offAll(() => const SignIn());
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        color: kwhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.h),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    try {
      final user = _authController.auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(_nameController.text);
        Get.snackbar(
          'Profile Updated',
          'Your profile has been successfully updated.',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      // Show an error message
      Get.snackbar(
        'Error',
        'Failed to update profile. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
