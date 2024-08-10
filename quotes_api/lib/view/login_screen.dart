import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../controller.dart/auth_controller.dart';
import '../utils/colors.dart';
import '../widget/spacing.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    child: SafeArea(
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.wifi_rounded,
                                color: kblack,
                                size: 26,
                              ),
                            ),
                            addVerticalSpacing(25),
                            const Center(
                              child: Text(
                                'Sign In',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                            addVerticalSpacing(40),
                            const Text(
                              'Email Address',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter'),
                            ),
                            addVerticalSpacing(4),
                            SizedBox(
                              height: 48,
                              child: TextFormField(
                                cursorHeight: 20,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: kblack,
                                    fontFamily: 'Inter'),
                                controller: controller.signEmailController,
                                validator: controller.emailValidator,
                                decoration: InputDecoration(
                                    focusedErrorBorder: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(4),
                                    hintText: 'Enter email',
                                    hintStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: kgrey5,
                                        fontFamily: 'Inter'),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: kgrey4, width: 1),
                                      borderRadius: BorderRadius.circular(14),
                                    )),
                              ),
                            ),
                            addVerticalSpacing(16),
                            const Text(
                              'Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter'),
                            ),
                            addVerticalSpacing(4),
                            SizedBox(
                              height: 48,
                              child: TextFormField(
                                obscureText: controller.passwordVisible.value,
                                controller: controller.signPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                validator: controller.passwordValidator,
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller.passwordVisible.value =
                                            !controller.passwordVisible.value;
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: controller.passwordVisible.value
                                            ? Image.asset(
                                                'assets/icons/hide.png',
                                              )
                                            : Image.asset(
                                                'assets/icons/view.png',
                                              ),
                                      ),
                                    ),
                                    focusedErrorBorder: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(4),
                                    suffixIconConstraints: const BoxConstraints(
                                        maxHeight: 24,
                                        maxWidth: 24,
                                        minHeight: 24,
                                        minWidth: 24),
                                    focusColor: kblack,
                                    hintText: 'Enter password',
                                    hintStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: kgrey5,
                                        fontFamily: 'Inter'),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: kgrey4, width: 1),
                                      borderRadius: BorderRadius.circular(14),
                                    )),
                              ),
                            ),
                            addVerticalSpacing(27),
                            GestureDetector(
                              onTap: () async {
                                try {
                                  if (_formKey.currentState!.validate()) {
                                    if (controller.passwordController.text ==
                                        controller.repasswordController.text) {
                                    } else {
                                      return _showalertdialog('', context);
                                    }
                                    if (_formKey.currentState!.validate()) {
                                      final res = await controller.signIn(
                                        controller.signEmailController.text,
                                        controller.signPasswordController.text,
                                      );
                                      print('ressssssssss:$res');
                                      Get.offAll(() => HomeScreen());
                                    }
                                  }
                                } on FirebaseAuthException catch (e) {
                                  var message = e.message;
                                  _showalertdialog(message.toString(), context);
                                  controller.isLoadingEmail.value = false;
                                }
                              },
                              child: Container(
                                height: 56,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: kblack,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Center(
                                  child:
                                      controller.isLoadingEmail.value == false
                                          ? const Text(
                                              'Sign In',
                                              style: TextStyle(
                                                  color: kwhite,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16),
                                            )
                                          : const CircularProgressIndicator(
                                              color: kwhite,
                                            ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                      child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: const TextStyle(
                            color: kgrey5,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter'),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Sign Up',
                              style: const TextStyle(
                                  color: kblack,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter'),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => const Signup());
                                })
                        ]),
                  )),
                  // )
                ])));
  }

  _showalertdialog(String errorMsg, BuildContext context) {
    return Alert(
      context: context,
      type: AlertType.error,
      title: "An error occured",
      style: AlertStyle(
        descStyle: TextStyle(
            color: kblack.withOpacity(0.6),
            fontSize: 16,
            fontWeight: FontWeight.w500),
        titleStyle: const TextStyle(
            color: kblack, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      desc: errorMsg,
      buttons: [
        DialogButton(
          color: kblack,
          onPressed: () => Navigator.pop(context),
          width: 120.w,
          child: const Text(
            "Click to fix",
            style: TextStyle(
                color: kwhite, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        )
      ],
    ).show();
  }
}
