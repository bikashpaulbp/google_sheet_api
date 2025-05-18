import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v2.dart' as drive;
import 'package:password_manager/app/core/local_data/local_data_key.dart';
import 'package:password_manager/app/core/local_data/storage_helper.dart';
import 'package:password_manager/app/models/password_model.dart';

import 'package:password_manager/app/services/google_sheets_service.dart';

class HomeController extends GetxController {
  RxList<PasswordModel> passList = RxList();

  RxBool isLoading = false.obs;
  // final DriveBackupManager _backupManager = DriveBackupManager(googleDriveService, 'password_manager_backup.json');
  final _spreadsheetId = 'your id';
  final _worksheetName = 'your sheet name';

  RxString email = "".obs;

  RxList<PasswordModel> allList = RxList();

  RxInt totalRow = 0.obs;

  @override
  void onInit() async {
    await getAllData();

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Future<void> getList() async {

  //   var result = LocalStorageHelper.get<List<dynamic>>(LocalDataKey.passListKey);
  //   if (result != null) {
  //     passList.value = result.map((item) => PasswordModel.fromJson(item)).toList();
  //   } else {
  //     passList.value = [];
  //   }
  // }

  Future<void> saveData(PasswordModel data) async {
    try {
      isLoading.value = true;
      final ss = await GoogleSheetsService.gSheets.spreadsheet(_spreadsheetId);
      final worksheet = ss.worksheetByTitle(_worksheetName);

      final newRow = [data.id.toString(), data.email, data.site, data.userId, data.password];

      await worksheet!.values.appendRow(newRow);
        await getTotalRowCount();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e.toString().contains('SocketException')) {
        Get.snackbar("Network Error", " Try again later.");
      } else {
        isLoading.value = false;
        Get.snackbar("Error", " Failed to save data: $e");
      }
    }
  }

  Future<List<PasswordModel>> getAllData() async {
    email.value = await LocalStorageHelper.get<String>(LocalDataKey.emailKey) ?? "";
    try {
      isLoading.value = true;
      final ss = await GoogleSheetsService.gSheets.spreadsheet(_spreadsheetId);
      final worksheet = ss.worksheetByTitle(_worksheetName);

      final data = await worksheet!.values.allRows();

      final rows = data.skip(1);

      final List<PasswordModel> models =
          rows.map((row) {
            return PasswordModel(id: int.tryParse(row[0]) ?? 0, email: row[1], site: row[2], userId: row[3], password: row[4]);
          }).toList();
    await getTotalRowCount();
      allList.value = models;
      passList.value = allList.where((e) => e.email == email.value).toList();
      isLoading.value = false;
      return passList;
    } catch (e) {
      isLoading.value = false;
      if (e.toString().contains('SocketException')) {
        Get.snackbar("Network Error", " Try again later.");
      } else {
        isLoading.value = false;
        Get.snackbar("Error", " Something went wrong: $e");
      }
      return [];
    }
  }

  Future<void> deleteDataById(int id) async {
    try {
      isLoading.value = true;
      final ss = await GoogleSheetsService.gSheets.spreadsheet(_spreadsheetId);
      final worksheet = ss.worksheetByTitle(_worksheetName);
      final rows = await worksheet!.values.allRows();

      for (int i = 1; i < rows.length; i++) {
        if (int.tryParse(rows[i][0]) == id) {
          await worksheet.deleteRow(i + 1);
          await getTotalRowCount();
          return;
        }
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e.toString().contains('SocketException')) {
        Get.snackbar("Network Error", " Try again later.");
      } else {
        isLoading.value = false;
        Get.snackbar("Error", " Failed to delete data: $e");
      }
    }
  }

  Future<void> updateDataById(PasswordModel updated) async {
    try {
      final ss = await GoogleSheetsService.gSheets.spreadsheet(_spreadsheetId);
      final worksheet = ss.worksheetByTitle(_worksheetName);
      final rows = await worksheet!.values.allRows();

      for (int i = 1; i < rows.length; i++) {
        if (int.tryParse(rows[i][0]) == updated.id) {
          await worksheet.values.insertRow(i + 1, [updated.id.toString(), updated.email, updated.site, updated.userId, updated.password]);

          return;
        }
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        Get.snackbar("Network Error", " Try again later.");
      } else {
        Get.snackbar("Error", " Failed to update data: $e");
      }
    }
  }

  Future<int> getTotalRowCount() async {
    final ss = await GoogleSheetsService.gSheets.spreadsheet(_spreadsheetId);
    final worksheet = ss.worksheetByTitle(_worksheetName)!;
    final allRows = await worksheet.values.allRows();
    totalRow.value = allRows.length - 1;
    return allRows.length - 1;
  }

  // Example backup function
  // Future<void> backupData() async {
  //   isLoading.value = true;
  //   try {
  //     // Ensure user is signed in.
  //     if (!googleDriveService.isSignedIn()) {
  //       await googleDriveService.signIn();
  //     }
  //     await _backupManager.uploadBackup();
  //     Get.snackbar('Backup Successful', 'Your data has been backed up to Google Drive.', snackPosition: SnackPosition.BOTTOM);
  //   } catch (e) {
  //     Get.snackbar('Backup Failed', 'Failed to backup data: $e', snackPosition: SnackPosition.BOTTOM, backgroundColor: Get.theme.colorScheme.error, colorText: Get.theme.colorScheme.onError);
  //     debugPrint(" bbbbbbbbbbbbbbbbbbbbbbbbb $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Example restore function
  // Future<void> restoreData() async {
  //   isLoading.value = true;
  //   try {
  //     // Ensure user is signed in.
  //     if (!googleDriveService.isSignedIn()) {
  //       await googleDriveService.signIn();
  //     }
  //     final backupData = await _backupManager.downloadBackup();
  //     if (backupData == null) {
  //       Get.snackbar('No Backup Found', 'No backup data found on Google Drive.  Skipping restore.', snackPosition: SnackPosition.BOTTOM);
  //       isLoading.value = false;
  //       return; // Exit the function
  //     }

  //     // 1. Decode he JSON data.
  //     Map<String, dynamic> decodedData = jsonDecode(backupData);

  //     // 2. Extract the password list.
  //     List<dynamic> passwordList = decodedData['passwords'] ?? [];

  //     // 3. Convert the list of dynamic maps to PasswordModel objects.
  //     List<PasswordModel> restoredPasswords = passwordList.map((item) => PasswordModel.fromJson(item)).toList();

  //     // 4.  Update the local storage.
  //     await LocalStorageHelper.save(LocalDataKey.passListKey, restoredPasswords); // Directly save the list of PasswordModel
  //     passList.value = restoredPasswords; // Update the observable list
  //     passList.refresh();

  //     Get.snackbar('Restore Successful', 'Your data has been restored from Google Drive.', snackPosition: SnackPosition.BOTTOM);
  //   } catch (e) {
  //     Get.snackbar('Restore Failed', 'Failed to restore data: $e', snackPosition: SnackPosition.BOTTOM, backgroundColor: Get.theme.colorScheme.error, colorText: Get.theme.colorScheme.onError);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
