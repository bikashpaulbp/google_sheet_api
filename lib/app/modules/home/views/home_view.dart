import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:password_manager/app/core/Helper/encryption_helper.dart';
import 'package:password_manager/app/core/constants/colors.dart';
import 'package:password_manager/app/core/local_data/local_data_key.dart';
import 'package:password_manager/app/core/local_data/storage_helper.dart';
import 'package:password_manager/app/models/password_model.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  void _showEditPasswordBottomSheet(BuildContext context, PasswordModel password) {
    TextEditingController siteController = TextEditingController(text: password.site);
    // TextEditingController emailController = TextEditingController(text: password.email);
    TextEditingController userIdController = TextEditingController(text: password.userId);
    TextEditingController passController = TextEditingController(text: EncryptionHelper.decrypt(password.password));

    showModalBottomSheet<void>(
      backgroundColor: Get.isDarkMode ? Colors.grey[900] : CustomColors.appBarColor,
      context: context,
      isScrollControlled: true,
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Edit Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Get.isDarkMode ? Colors.white : Colors.black87)),
                  const SizedBox(height: 20),
                  TextField(controller: siteController, decoration: InputDecoration(labelText: 'Site URL', border: const OutlineInputBorder(), labelStyle: TextStyle(color: Get.isDarkMode ? Colors.white70 : Colors.black54), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Get.isDarkMode ? Colors.white60 : Colors.grey)), focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))), style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black87)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: userIdController,
                    decoration: InputDecoration(labelText: 'User ID/Email for this site', border: const OutlineInputBorder(), labelStyle: TextStyle(color: Get.isDarkMode ? Colors.white70 : Colors.black54), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Get.isDarkMode ? Colors.white60 : Colors.grey)), focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
                    style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  TextField(controller: passController, decoration: InputDecoration(labelText: 'Password', border: const OutlineInputBorder(), labelStyle: TextStyle(color: Get.isDarkMode ? Colors.white70 : Colors.black54), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Get.isDarkMode ? Colors.white60 : Colors.grey)), focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))), style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black87)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () => Navigator.pop(ctx), style: TextButton.styleFrom(foregroundColor: CustomColors.cancelBtnColor), child: const Text('Cancel')),
                      const SizedBox(width: 20),
                      Obx(
                        () =>
                            controller.isLoading.value == true
                                ? Center(child: CircularProgressIndicator(color: const Color.fromARGB(255, 30, 19, 50)))
                                : ElevatedButton(
                                  onPressed: () async {
                                    if (passController.text.isNotEmpty && siteController.text.isNotEmpty && userIdController.text.isNotEmpty) {
                                      controller.isLoading.value = true;
                                      String enPass = EncryptionHelper.encrypt(passController.text);

                                      final updatedModel = PasswordModel(id: password.id, email: controller.email.value, userId: userIdController.text, password: enPass, site: siteController.text);

                                      controller.passList.value =
                                          controller.passList.map((p) {
                                            return p.id == password.id ? updatedModel : p;
                                          }).toList();
                                      controller.passList.refresh();
                                      await controller.updateDataById(updatedModel);
                                      controller.isLoading.value = false;
                                      Navigator.pop(ctx);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: CustomColors.saveBtnColor),
                                  child: controller.isLoading.value ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white)) : const Text('Save', style: TextStyle(color: Colors.white)),
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
    );
  }

  void _addPassModalSheet(BuildContext ctx) {
    TextEditingController siteController = TextEditingController();
    // TextEditingController emailController = TextEditingController();
    TextEditingController userIdController = TextEditingController();
    TextEditingController passController = TextEditingController();

    showModalBottomSheet<void>(
      backgroundColor: Get.isDarkMode ? Colors.grey[900] : CustomColors.appBarColor,
      context: ctx,
      isScrollControlled: true,
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Save New Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Get.isDarkMode ? Colors.white : Colors.black87)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: siteController,
                    decoration: InputDecoration(labelText: 'Paste Site URL', border: const OutlineInputBorder(), labelStyle: TextStyle(color: Get.isDarkMode ? Colors.white70 : Colors.black54), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Get.isDarkMode ? Colors.white60 : Colors.grey)), focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
                    style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: userIdController,
                    decoration: InputDecoration(labelText: 'User ID/Email for this site', border: const OutlineInputBorder(), labelStyle: TextStyle(color: Get.isDarkMode ? Colors.white70 : Colors.black54), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Get.isDarkMode ? Colors.white60 : Colors.grey)), focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
                    style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passController,
                    decoration: InputDecoration(labelText: 'Enter Password for this site', border: const OutlineInputBorder(), labelStyle: TextStyle(color: Get.isDarkMode ? Colors.white70 : Colors.black54), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Get.isDarkMode ? Colors.white60 : Colors.grey)), focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
                    style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.isLoading.value = false;
                          Get.back();
                        },
                        style: TextButton.styleFrom(foregroundColor: CustomColors.cancelBtnColor),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 20),
                      Obx(
                        () =>
                            controller.isLoading.value == true
                                ? Center(child: CircularProgressIndicator(color: const Color.fromARGB(255, 30, 19, 50)))
                                : ElevatedButton(
                                  onPressed: () async {
                                    if (passController.text.isNotEmpty && siteController.text.isNotEmpty && userIdController.text.isNotEmpty) {
                                      controller.isLoading.value = true;
                                      String enPass = EncryptionHelper.encrypt(passController.text);
                                      int newId = controller.totalRow.value == 0 ? 1 : controller.totalRow.value + 1;
                                      PasswordModel newModel = PasswordModel(id: newId, email: controller.email.value, userId: userIdController.text, password: enPass, site: siteController.text);
                                      await controller.saveData(newModel);
                                      controller.passList.add(newModel);
                                      controller.passList.refresh();
                                      controller.isLoading.value = false;
                                      Get.back();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: CustomColors.saveBtnColor),
                                  child: Obx(() => controller.isLoading.value ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white)) : const Text('Save', style: TextStyle(color: Colors.white))),
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.grey[800] : CustomColors.appBarColor,
        actions: [
          IconButton(
            onPressed: () {
              _addPassModalSheet(context);
            },
            icon: const Icon(Icons.add),
            color: Get.isDarkMode ? Colors.white : Colors.black87,
          ),

          // Changed to Column
          // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [ElevatedButton(onPressed: controller.backupData, child: const Text('Backup Data')), ElevatedButton(onPressed: controller.restoreData, child: const Text('Restore Data'))]),
        ],
        title: Text('Password List', style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black87)),
        centerTitle: true,
      ),
      body: Obx(
        () => ModalProgressHUD(
          progressIndicator: Center(child: CircularProgressIndicator(color: const Color.fromARGB(255, 30, 19, 50))),
          inAsyncCall: controller.isLoading.value,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () =>
                    controller.passList.isEmpty
                        ? Center(child: Text('No passwords saved yet. Click the + icon to add.', textAlign: TextAlign.center, style: TextStyle(color: Get.isDarkMode ? Colors.white70 : Colors.black54)))
                        : ListView.builder(
                          itemCount: controller.passList.length,
                          itemBuilder: (context, index) {
                            final PasswordModel passList = controller.passList[index];
                            final String decryptedPassword = EncryptionHelper.decrypt(passList.password);

                            return SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              child: Dismissible(
                                key: Key(passList.id.toString()),
                                direction: DismissDirection.horizontal,
                                confirmDismiss: (direction) async {
                                  if (direction == DismissDirection.startToEnd) {
                                    return true;
                                  } else if (direction == DismissDirection.endToStart) {
                                    _showEditPasswordBottomSheet(context, passList);
                                    return false;
                                  }
                                  return false;
                                },
                                onDismissed: (direction) async {
                                  if (direction == DismissDirection.startToEnd) {
                                    controller.isLoading.value = true;

                                    controller.passList.removeWhere((item) => item.id == passList.id);
                                    controller.passList.refresh();

                                    await controller.deleteDataById(passList.id);

                                    controller.isLoading.value = false;

                                    Get.snackbar('Password Deleted', 'The password for ${passList.site} has been deleted.', snackPosition: SnackPosition.BOTTOM, backgroundColor: CustomColors.cancelBtnColor.withOpacity(0.8), colorText: Colors.white);
                                  }
                                },
                                background: Container(color: Colors.redAccent, alignment: Alignment.centerLeft, padding: const EdgeInsets.symmetric(horizontal: 20.0), child: const Icon(Icons.delete, color: Colors.white)),
                                secondaryBackground: Container(color: Colors.blueAccent, alignment: Alignment.centerRight, padding: const EdgeInsets.symmetric(horizontal: 20.0), child: const Icon(Icons.edit, color: Colors.white)),
                                child: Card(
                                  color: Get.isDarkMode ? Colors.grey[850] : Colors.white,
                                  elevation: 2,
                                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(children: [const Icon(Icons.language, color: Colors.grey), const SizedBox(width: 12), Expanded(child: Text(passList.site ?? 'No Site Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Get.isDarkMode ? Colors.white : Colors.black87), overflow: TextOverflow.ellipsis))]),
                                        const SizedBox(height: 8),
                                        Row(children: [const Icon(Icons.person, color: Colors.grey), const SizedBox(width: 12), Expanded(child: Text(passList.userId ?? 'No User Id', style: TextStyle(fontSize: 16, color: Get.isDarkMode ? Colors.white70 : Colors.black54), overflow: TextOverflow.ellipsis))]),
                                        const SizedBox(height: 8),
                                        Row(children: [const Icon(Icons.lock, color: Colors.grey), const SizedBox(width: 12), Expanded(child: Text(decryptedPassword, style: TextStyle(fontSize: 16, color: Get.isDarkMode ? Colors.white70 : Colors.black54), overflow: TextOverflow.ellipsis))]),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
