import 'dart:convert';

import 'package:zamzam/features/auth_feature/model/user_model.dart';

class RegisterModel {
  UserModel userModel;
  String email;
  RegisterModel({
    required this.userModel,
    required this.email,
  });

  RegisterModel copyWith({
    UserModel? userModel,
    String? email,
  }) {
    return RegisterModel(
      userModel: userModel ?? this.userModel,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'userModel': userModel.toMap()});
    result.addAll({'email': email});
  
    return result;
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      userModel: UserModel.fromMap(map['userModel']),
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) => RegisterModel.fromMap(json.decode(source));

  @override
  String toString() => 'RegisterModel(userModel: $userModel, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RegisterModel &&
      other.userModel == userModel &&
      other.email == email;
  }

  @override
  int get hashCode => userModel.hashCode ^ email.hashCode;
}
