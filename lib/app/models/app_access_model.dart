class AppAccessModel {
  final String appName;
  final bool isValid;

  AppAccessModel({required this.appName, required this.isValid});

  factory AppAccessModel.fromJson(Map<String, dynamic> json) {
    return AppAccessModel(
      appName: json['appName'],
      isValid: json['isValid'].toString().toLowerCase() == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appName': appName,
      'isValid': isValid.toString(),
    };
  }

  static List<AppAccessModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AppAccessModel.fromJson(json)).toList();
  }
}
