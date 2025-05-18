class PasswordModel {
  final int id;
  final String email;
  final String site;
  final String userId;
  final String password;

  PasswordModel( {required this.id, required this.email, required this.site,  required this.userId, required this.password, });

  factory PasswordModel.fromJson(Map<String, dynamic> json) {
    return PasswordModel(
      id: json['id'] as int, 
      email: json['email'] as String, 
      site: json['site'] as String, 
      userId: json['userId'] as String, 
      password: json['password'] as String
      );
  }



  Map<String, dynamic> toJson() => {
    'id': id, 
    'email': email, 
    'site': site, 
    'userId': userId, 
    'password': password
    };
}
