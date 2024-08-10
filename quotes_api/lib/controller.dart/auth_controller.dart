import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/validator.dart';

class AuthController extends GetxController {
  final Rx<File?> _imageFile = Rx<File?>(null);

  File? get imageFile => _imageFile.value;

  void updateImage(File image) {
    _imageFile.value = image;
  }

  // Controllers for Sign Up
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get repasswordController => _repasswordController;

  // Controllers for Sign In
  final _signEmailController = TextEditingController();
  final _signPasswordController = TextEditingController();

  TextEditingController get signEmailController => _signEmailController;
  TextEditingController get signPasswordController => _signPasswordController;

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  final RxBool _passwordVisible = true.obs;
  RxBool isLoadingEmail = false.obs;
  RxBool isLoadingGoogle = false.obs;

  RxBool get passwordVisible => _passwordVisible;

  set passwordVisible(RxBool val) {
    _passwordVisible.value = val.value;
  }

  String? Function(String? email) get emailValidator =>
      Validators.emailValidator;
  String? Function(String? password) get passwordValidator =>
      Validators.passwordValidator;

  // Sign Up
  Future<bool> signUp(String email, String password) async {
    try {
      isLoadingEmail.value = true;
      final u = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = u.user;
      isLoadingEmail.value = false;
      return true;
    } catch (e) {
      isLoadingEmail.value = false;
      print('Error during sign up: $e');
      return false;
    }
  }

  // Sign In
  Future<bool> signIn(String email, String password) async {
    try {
      isLoadingEmail.value = true;
      final u = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = u.user;
      print('User signed in with UID: ${u.user?.uid}');
      isLoadingEmail.value = false;
      return true;
    } catch (e) {
      isLoadingEmail.value = false;
      print('Error during sign in: $e');
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await auth.signOut();
      user = null;
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print('Error during Google sign out: $e');
      return false;
    }
  }

  @override
  void onClose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
    _signEmailController.dispose();
    _signPasswordController.dispose();
    super.onClose();
  }
}
