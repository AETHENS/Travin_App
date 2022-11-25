// To parse this JSON data, do
//
//     final registerUserModel = registerUserModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RegisterUserModel registerUserModelFromJson(String str) =>
    RegisterUserModel.fromJson(json.decode(str));

String registerUserModelToJson(RegisterUserModel data) =>
    json.encode(data.toJson());

class RegisterUserModel {
  RegisterUserModel({
    required this.message,
    required this.data,
    required this.accessToken,
    required this.tokenType,
  });

  String message;
  Data data;
  String accessToken;
  String tokenType;

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) =>
      RegisterUserModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
      };
}

class Data {
  Data({
    required this.name,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String name;
  String email;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
