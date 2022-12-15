import 'package:seerooms/models/models.dart';
import 'package:flutter/material.dart';

class PlaceFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  PlaceModel? place;

  PlaceFormProvider(this.place);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
