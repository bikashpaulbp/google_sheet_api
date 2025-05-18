import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:password_manager/app/core/constants/colors.dart';



SnackbarController showSnackBar({required String text}) {
  return Get.showSnackbar(
    GetSnackBar(
      messageText: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      backgroundColor: CustomColors.themeColor,
      margin: EdgeInsets.all(0),
      borderRadius: 0,
      duration: Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
    ),
  );
}
