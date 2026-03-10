// lib/app/models/user_model.dart

class UserModel {
  final int    id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
    id:    j['id'] is int ? j['id'] : int.parse(j['id'].toString()),
    name:  j['name']  ?? '',
    email: j['email'] ?? '',
  );
}