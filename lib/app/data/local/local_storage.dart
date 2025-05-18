//  import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LocalStorage {
 
// //  Future<void> saveGeoToStorage<T>(String key, List<GeographicalHierarchyModel> list) async {
// //   final jsonList = list.map((item) => item.toJson()).toList();
// //   final box = GetStorage(); // GetStorage instance
// //   await box.write(key, jsonList);
// // }


//   // static Future<void> saveLoggedInUser(UserModel loggedInUser) async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   final userJson = jsonEncode(loggedInUser.toJson());
//   //   await prefs.setString('loggedInUserTM', userJson);
//   // }

//   // static Future<UserModel?> getLoggedInUser() async {
//   //   try {
//   //     SharedPreferences prefs = await SharedPreferences.getInstance();
//   //     final userJson = prefs.getString('loggedInUserTM');
//   //     if (userJson != null) {
//   //       final userMap = jsonDecode(userJson);
//   //       return UserModel.fromJson(userMap);
//   //     }
//   //   } catch (e) {
//   //     debugPrint("Error retrieving user data: $e");
//   //   }
//   //   return null;
//   // }

//   static Future<void> removeLoggedInUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('loggedInUserTM');
//   }

//   static Future<void> saveIsRemember(bool isRemember) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isRememberTM', true);
//   }

//   static Future<bool> getIsRemember() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('isRememberTM') ?? false;
//   }

//   static Future<void> removeIsRemember() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('isRememberTM');
//   }

//   static Future<void> saveRequestOffline(String url, Map<String, dynamic> data) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> offlineRequests = prefs.getStringList('offlineRequests') ?? [];

//     offlineRequests.add(jsonEncode({'url': url, 'data': data}));
//     await prefs.setStringList('offlineRequests', offlineRequests);
//   }

//   // static Future<void> saveFarmerGroupRequestOffline(String url, Item data) async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   List<String> saveFarmerGroup = prefs.getStringList('saveFarmerGroup') ?? [];

//   //   saveFarmerGroup.add(jsonEncode({
//   //     'url': url,
//   //     'data': data.toJson(),
//   //   }));

//   //   await prefs.setStringList('saveFarmerGroup', saveFarmerGroup);
//   // }

//   //save data by Get storage

//   static final box = GetStorage();

//   static Future<void> _saveList(Map<String, dynamic> data) async {
//     box.write(data["key"], data["list"]);
//   }

//   // static Future<void> saveDistrictList(List<GeographicalHierarchyModel> list) async {
//   //   await compute(_saveList, {"key": "districtList", "list": list.map((district) => district.toJson()).toList()});
//   // }

//   // static Future<void> saveUpazilaList(List<GeographicalHierarchyModel> list) async {
//   //   await compute(_saveList, {'key': 'upazilaList', 'list': list.map((item) => item.toJson()).toList()});
//   // }

//   // static Future<void> saveUnionList(List<GeographicalHierarchyModel> list) async {
//   //   await compute(_saveList, {'key': 'unionList', 'list': list.map((item) => item.toJson()).toList()});
//   // }

//   // static Future<void> saveVillageList(List<GeographicalHierarchyModel> list) async {
//   //   await compute(_saveList, {'key': 'villageList', 'list': list.map((item) => item.toJson()).toList()});
//   // }

//   // static Future<void> saveFarmerGroupList(List<Item> list) async {
//   //   await compute(_saveList, {'key': 'farmerGroupList', 'list': list.map((item) => item.toJson()).toList()});
//   // }

//   // static Future<List<GeographicalHierarchyModel>> getDistrict() async {
//   //   List<dynamic> jsonList = await box.read('districtList');
//   //   return jsonList.map((json) => GeographicalHierarchyModel.fromJson(json)).toList();
//   // }

//   // static Future<List<GeographicalHierarchyModel>> getUpazila() async {
//   //   List<dynamic> jsonList = await box.read('upazilaList');
//   //   return jsonList.map((json) => GeographicalHierarchyModel.fromJson(json)).toList();
//   // }

//   // static Future<List<GeographicalHierarchyModel>> getUnion() async {
//   //   List<dynamic> jsonList = await box.read('unionList');
//   //   return jsonList.map((json) => GeographicalHierarchyModel.fromJson(json)).toList();
//   // }

//   // static Future<List<GeographicalHierarchyModel>> getVillage() async {
//   //   List<dynamic> jsonList = await box.read('villageList');
//   //   return jsonList.map((json) => GeographicalHierarchyModel.fromJson(json)).toList();
//   // }

//   // static Future<List<Item>> getFarmerGroups() async {
//   //   List<dynamic> jsonList = await box.read('farmerGroupList');
//   //   return jsonList.map((json) => Item.fromJson(json)).toList();
//   // }
// }