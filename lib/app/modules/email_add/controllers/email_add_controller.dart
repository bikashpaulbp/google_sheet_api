import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';

class EmailAddController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement EmailAddController

  final count = 0.obs;

  RxBool isLoading = false.obs;

  Rx<TextEditingController> emailController = TextEditingController().obs;
  // Rx<TextEditingController> passwordController = TextEditingController().obs;

  late final gifController;

  Rx<bool> isValid = false.obs;

  @override
  void onInit() {

    gifController = GifController(vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
  
    super.onReady();
  }

  @override
  void onClose() {
    gifController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
