import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:seerooms/models/models.dart';
import 'package:http/http.dart' as http;

class PlaceService extends ChangeNotifier {
  final String _baseUrl = 'seerooms-63da8-default-rtdb.firebaseio.com';

  final List<PlaceModel> places = [];

  PlaceModel? selectedPlace;

  File? newPhotoFile;

  bool isLoading = true;
  bool isSaving = true;

  PlaceService() {
    loadPlace();
  }
  Future<String> creatPlace(PlaceModel place) async {
    final url = Uri.https(_baseUrl, 'place.json');
    final resp = await http.post(url, body: place.toJson());
    final decodeData = json.decode(resp.body);

    place.id = decodeData['name'];

    this.places.add(place);
    return place.id!;
  }

  Future saveOrCreatePlace(PlaceModel place) async {
    isSaving = true;
    notifyListeners();

    if (place.id == null) {
      await this.creatPlace(place);
    } else {
      await this.updatePlace(place);
    }
    isSaving = false;
    notifyListeners();
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

  void updateSelectedProductImage(String path) {
    this.selectedPlace!.photo = path;
    this.newPhotoFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> updatePlace(PlaceModel place) async {
    final url = Uri.https(_baseUrl, 'place/${place.id}.json');
    final resp = await http.put(url, body: place.toJson());
    final decodedData = resp.body;
    final index = this.places.indexWhere((element) => element.id == place.id);
    this.places[index] = place;
    return place.id!;
  }

  Future<String?> uploadImage() async {
    if (this.newPhotoFile == null) return null;

    this.isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dgb26cwpx/image/upload?upload_preset=xxcbv5ri');
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', newPhotoFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    this.newPhotoFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
