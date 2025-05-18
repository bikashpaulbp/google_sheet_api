import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class LocalStorageHelper {
   static GetStorage _box = GetStorage();

  static Future<void> init() async {
    await GetStorage.init();
  }

  static Future<void>  save<T>(String key, T value) async {
    if (value is Map<String, dynamic> || value is List<Map<String, dynamic>>) {
      await _box.write(key, jsonEncode(value));
    } else {
      await _box.write(key, value);
    }
  }

  static T? get<T>(String key) {
    final dynamic data = _box.read(key);

    if (data == null) {
      return null;
    }

    if (T == String) {
      return data as T;
    } else if (T == int) {
      return data as T;
    } else if (T == double) {
      return data as T;
    } else if (T == bool) {
      return data as T;
    } else if (T == Map<String, dynamic>) {
      if (data is String) {
        return jsonDecode(data) as T;
      }
      return data as T;
    } else if (T == List<dynamic>) {
      if (data is String) {
        return jsonDecode(data) as T;
      }
      return data as T;
    }
    // Add more type checks here for your custom models and lists of models

    // If the type is not explicitly handled, return as dynamic (you might want to refine this)
    return data;
  }

  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  Future<void> clear() async {
    await _box.erase();
  }
}

// Example Usage and Self-Testing:

// class User {
//   final String name;
//   final int age;

//   User({required this.name, required this.age});

//   Map<String, dynamic> toJson() {
//     return {'name': name, 'age': age};
//   }

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(name: json['name'], age: json['age']);
//   }

//   @override
//   String toString() {
//     return 'User(name: $name, age: $age)';
//   }
// }


// example of uses
// void main() async {
//   await GetStorage.init();
//   final localStorage = LocalStorageHelper();

//   // Test saving different data types
//   await localStorage.save('string_key', 'Hello Get Storage!');
//   await localStorage.save('int_key', 123);
//   await localStorage.save('double_key', 3.14);
//   await localStorage.save('bool_key', true);
//   await localStorage.save('map_key', {'name': 'John', 'age': 30});
//   await localStorage.save('list_key', [1, 2, 3, 4, 5]);

//   final user = User(name: 'Alice', age: 25);
//   await localStorage.save('user_key', user.toJson());

//   final users = [User(name: 'Bob', age: 40), User(name: 'Charlie', age: 35)];
//   await localStorage.save('users_key', users.map((u) => u.toJson()).toList());

//   // Test retrieving different data types
//   print('String: ${localStorage.get<String>('string_key')}');
//   print('Int: ${localStorage.get<int>('int_key')}');
//   print('Double: ${localStorage.get<double>('double_key')}');
//   print('Bool: ${localStorage.get<bool>('bool_key')}');
//   print('Map: ${localStorage.get<Map<String, dynamic>>('map_key')}');
//   print('List: ${localStorage.get<List<dynamic>>('list_key')}');

//   final retrievedUserMap = localStorage.get<Map<String, dynamic>>('user_key');
//   if (retrievedUserMap != null) {
//     final retrievedUser = User.fromJson(retrievedUserMap);
//     print('User: $retrievedUser');
//   }

//   final retrievedUsersList = localStorage.get<List<dynamic>>('users_key');
//   if (retrievedUsersList != null) {
//     final retrievedUsers = retrievedUsersList.map((item) => User.fromJson(item)).toList();
//     print('Users: $retrievedUsers');
//   }

  // Test removing and clearing
  // await localStorage.remove('string_key');
  // print('String after remove: ${localStorage.get<String>('string_key')}');

  // await localStorage.clear();
  // print('Int after clear: ${localStorage.get<int>('int_key')}');
//}