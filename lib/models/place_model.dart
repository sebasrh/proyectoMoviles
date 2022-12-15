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
    this.photos,
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
  List<String>? photos;
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
        photos: List<String>.from(json["photos"].map((x) => x)),
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
        "photos": List<dynamic>.from(photos!.map((x) => x)),
        "price": price,
      };
  PlaceModel copy() => PlaceModel(
        address: address,
        available: available,
        city: city,
        departament: departament,
        neighborhood: neighborhood,
        numberPhone: numberPhone,
        owner: owner,
        photos: photos,
        price: price,
        id: id,
      );
}
