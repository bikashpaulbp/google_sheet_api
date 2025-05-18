import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void showAlertDialog(String message) {
  Get.defaultDialog(
    titleStyle: TextStyle(color: Colors.red),
    title: "Error",
    middleText: message,
    textConfirm: "OK",
    onConfirm: () {
      Get.back();
    },
    barrierDismissible: false,
  );
}