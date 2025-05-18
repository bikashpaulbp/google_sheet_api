import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gif/gif.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    SplashScreenController controller = Get.put(SplashScreenController());

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('SplashScreenView'),
      //   centerTitle: true,
      // ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Gif(
          autostart: Autostart.loop,
          fit: BoxFit.cover,
          controller: controller.gifController,
          // fps: _fps,
          image: const AssetImage("lib/assets/splash.gif"),
        ),
      ),
    );
  }
}
