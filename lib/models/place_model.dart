// To parse this JSON data, do
//
//     final placeModel = placeModelFromMap(jsonString);

import 'dart:convert';

class PlaceModel {
  PlaceModel({
    required this.address,
    required this.available,
    required this.city,
    required this.departament,
    required this.neighborhood,
    required this.numberPhone,
    required this.owner,
    required this.photo,
    required this.price,
    this.id,
  });

  String address;
  bool available;
  String city;
  String departament;
  String neighborhood;
  String numberPhone;
  String owner;
  String photo;
  String price;
  String? id;

  factory PlaceModel.fromJson(String str) =>
      PlaceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlaceModel.fromMap(Map<String, dynamic> json) => PlaceModel(
        address: json["address"],
        available: json["available"],
        city: json["city"],
        departament: json["departament"],
        neighborhood: json["neighborhood"],
        numberPhone: json["numberPhone"],
        owner: json["owner"],
        photo: json["photo"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "available": available,
        "city": city,
        "departament": departament,
        "neighborhood": neighborhood,
        "numberPhone": numberPhone,
        "owner": owner,
        "photo": photo,
        "price": price,
      };

  PlaceModel copy() => PlaceModel(
        address: this.address,
        available: this.available,
        city: this.city,
        departament: this.departament,
        neighborhood: this.neighborhood,
        numberPhone: this.numberPhone,
        owner: this.owner,
        photo: this.photo,
        price: this.price,
        id: this.id,
      );
}
