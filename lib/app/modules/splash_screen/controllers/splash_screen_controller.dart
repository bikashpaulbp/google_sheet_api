import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:password_manager/app/core/local_data/local_data_key.dart';
import 'package:password_manager/app/core/local_data/storage_helper.dart';
import 'package:password_manager/app/data/local/local_storage.dart';
import 'package:password_manager/app/modules/face_auth/views/face_auth_view.dart';
import 'package:password_manager/app/modules/home/views/home_view.dart';
import 'package:password_manager/app/routes/app_pages.dart';

class SplashScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement SplashScreenController

  final count = 0.obs;

  late final gifController;
  @override
  void onInit() async {
    debugPrint("Splash init called");
    gifController = GifController(vsync: this);
    bool isEmailSavedKey = LocalStorageHelper.get<bool>(LocalDataKey.isEmailSavedKey) ?? false;

    Timer(const Duration(seconds: 5), () async {
      if (isEmailSavedKey) {
        Get.offAllNamed(Routes.FACE_AUTH);
      } else {
        Get.offAndToNamed(Routes.EMAIL_ADD);
      }

      // Get.offAll(() => FaceAuthView(), transition: Transition.fadeIn);
    });
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    gifController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
