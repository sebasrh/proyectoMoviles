import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:seerooms/models/models.dart';
import 'package:http/http.dart' as http;

class PlaceService extends ChangeNotifier {
  final String _baseUrl = 'seerooms-63da8-default-rtdb.firebaseio.com';

  final List<PlaceModel> places = [];

  PlaceModel? selectedPlace;

  bool isLoading = true;
  bool isSaving = true;

  PlaceService() {
    loadPlace();
  }
  Future<String> creatPlace(PlaceModel place) async {
    final url = Uri.https(_baseUrl, 'place.json');
    final resp = await http.post(url, body: place.toJson());
    final decodeData = resp.body;
    this.places.add(place);
    return place.id!;
  }

  Future saveOrCreatePlace(PlaceModel place) async {
    isSaving = true;
    notifyListeners();

    if (place.id == null) {
      await this.creatPlace(place);
    } else {
      
    }
  }

  Future<List<PlaceModel>> loadPlace() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'place.json');
    final resp = await http.get(url);

    final Map<String, dynamic> placeMap = json.decode(resp.body);

    placeMap.forEach((key, value) {
      final tempPlace = PlaceModel.fromMap(value);
      tempPlace.id = key;
      this.places.add(tempPlace);
    });
    this.isLoading = false;
    notifyListeners();
    return this.places;
  }
}
