import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/controllers/offline_request_controller.dart';
import 'package:password_manager/app/core/Helper/encryption_helper.dart';
import 'package:password_manager/app/core/local_data/storage_helper.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageHelper.init();
   await EncryptionHelper.initialize();

  runApp(
    GetMaterialApp(
      theme: ThemeData.dark(useMaterial3: true,),
      initialBinding: BindingsBuilder(() {
        // Get.put(OfflineRequestController());
      }),

      title: "Password Manager",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
