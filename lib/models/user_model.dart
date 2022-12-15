// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

class UserModel {
    UserModel({
      required this.email,
      required this.identification,
      required this.name,
      required this.numberPhone,
    });

    String email;
    int identification;
    String name;
    int numberPhone;

    factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
      email: json["email"],
      identification: json["identification"],
      name: json["name"],
      numberPhone: json["number_phone"],
    );

    Map<String, dynamic> toMap() => {
      "email": email,
      "identification": identification,
      "name": name,
      "number_phone": numberPhone,
    };
}
