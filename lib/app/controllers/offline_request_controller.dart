import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:password_manager/app/core/custom_widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineRequestController extends GetxController {
  //TODO: Implement OfflinerequestController

  final count = 0.obs;

  RxBool isOnline = false.obs;

  // UserModel? user;

  @override
  void onInit() async {
    // user = await LocalData.getLoggedInUser();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    initConnectivityListener();
    await processOfflineRequests();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void initConnectivityListener() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (results.isNotEmpty && results.first == ConnectivityResult.none) {
        debugPrint("listener called offline");
        isOnline.value = false;
        showSnackBar(text: "You are currently offline");
      } else {
        debugPrint("listener called online");
        isOnline.value = true;
        showSnackBar(text: "You are currently online");
        processOfflineRequests();
      }
    });
  }

  Future<void> processOfflineRequests() async {
    debugPrint("offline process called");
    await processOfflineRequestsSaveFarmerGroup();
  }

  Future<void> processOfflineRequestsSaveFarmerGroup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> saveFarmerGroup = prefs.getStringList('saveFarmerGroup') ?? [];
    List<String> itemsToRemove = []; // Create a temporary list for items to remove

    for (String request in saveFarmerGroup) {
      Map<String, dynamic> requestData = jsonDecode(request);

      try {
        final response = await http.post(
          Uri.parse(requestData['url']),
          headers: {
            // 'Authorization': 'Bearer ${user?.accessToken}',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(requestData['data']),
        );

        if (response.statusCode == 200) {
          showSnackBar(text: "Farmer Group saved successfully");
          itemsToRemove.add(request);
        } else if (response.statusCode == 401) {
          showSnackBar(text: "Unauthorized access. Please check token.");
          break;
        } else {
          debugPrint('Failed with status code: ${response.statusCode}');
        }
      } catch (e) {
        showSnackBar(text: "Retry failed, will try again later.");
        debugPrint('Retry failed, will try again later.');
        break;
      }
    }

    saveFarmerGroup.removeWhere((item) => itemsToRemove.contains(item));
    await prefs.setStringList('saveFarmerGroup', saveFarmerGroup);
  }

  void increment() => count.value++;
}