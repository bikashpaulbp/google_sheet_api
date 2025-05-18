import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:password_manager/app/core/constants/colors.dart';
import 'package:password_manager/app/core/custom_widgets/custom_text_widget.dart';
import 'package:password_manager/app/core/local_data/local_data_key.dart';
import 'package:password_manager/app/core/local_data/storage_helper.dart';
import 'package:password_manager/app/modules/face_auth/views/face_auth_view.dart';
import 'package:password_manager/app/modules/home/views/home_view.dart';

import '../controllers/email_add_controller.dart';

class EmailAddView extends GetView<EmailAddController> {
  const EmailAddView({super.key});
  @override
  Widget build(BuildContext context) {
    EmailAddController controller = Get.put(EmailAddController());
    return Scaffold(
      // appBar: AppBar(title: const Text('EmailAddView'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.black, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80), bottomRight: Radius.circular(80))),
                height: MediaQuery.of(context).size.height / 3.5,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80), bottomRight: Radius.circular(80)), child: Gif(autostart: Autostart.loop, fit: BoxFit.cover, controller: controller.gifController, image: const AssetImage("lib/assets/email.gif"))),
              ),

              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        height: 75,
                        child: TextFormField(
                          controller: controller.emailController.value,
                          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), labelText: "Enter your email"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            } else if (!GetUtils.isEmail(value)) {
                              return 'Please enter a valid email';
                            } else {
                              controller.isValid.value = true;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width / 1.1,
                child: Obx(
                  () =>
                      controller.isLoading == true
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                            style: ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))), backgroundColor: WidgetStatePropertyAll(CustomColors.saveBtnColor)),
                            onPressed: () async {
                              if (controller.emailController.value.text.isNotEmpty && controller.isValid.value) {
                                await LocalStorageHelper.save(LocalDataKey.isEmailSavedKey, true);
                                await LocalStorageHelper.save(LocalDataKey.emailKey, controller.emailController.value.text);
                                Get.offAll(() => FaceAuthView());
                              }
                            },
                            child: CustomTextWidget(text: "Save Email", color: Colors.white, bold: false, size: 18),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
