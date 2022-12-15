import 'package:flutter/material.dart';
import 'package:seerooms/providers/place_provider.dart';
import 'package:seerooms/widget/place_image.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../services/services.dart';

class PlacePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlacePage place;
    final placeService = Provider.of<PlaceService>(context);

    return ChangeNotifierProvider(
      create: (_) => PlaceFormProvider(placeService.selectedPlace),
      child: _PlacePageBody(placeService: placeService),
    );

    //return _PlacePageBody(placeService: placeService);
  }
}

class _PlacePageBody extends StatelessWidget {
  const _PlacePageBody({
    Key? key,
    required this.placeService,
  }) : super(key: key);

  final PlaceService placeService;

  @override
  Widget build(BuildContext context) {
    final placeForm = Provider.of<PlaceFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              PlaceImage(url: placeService.selectedPlace!.photo),
              Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () async {
                      final picker = new ImagePicker();
                      final PickedFile? pickedFile = await picker.getImage(
                          source: ImageSource.gallery, imageQuality: 100);

                      if (pickedFile == null) {
                        return;
                      }
                      placeService.updateSelectedProductImage(pickedFile.path);
                    },
                    icon: const Icon(Icons.camera_alt_outlined,
                        size: 40, color: Colors.white),
                  )),
            ],
          ),
          _PlaceForm(),
          SizedBox(height: 100),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save_outlined),
        onPressed: () async {
          if (!placeForm.isValidForm()) return;

          final String? imageUrl = await placeService.uploadImage();

          if(imageUrl != null){placeForm.place!.photo = imageUrl;}

          await placeService.saveOrCreatePlace(placeForm.place!);
          Navigator.pushNamed(context, 'home_page');
        },
      ),
    );
  }
}

class _PlaceForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final placeForm = Provider.of<PlaceFormProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: placeForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  placeForm.place!.owner = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Nombre del propietario',
                  labelText: 'Nombre del propietario:',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => placeForm.place!.numberPhone = value,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Numero de celular',
                  labelText: 'Numero de celular:',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                  onChanged: (value) => placeForm.place!.price = value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Precio del hospedaje',
                    labelText: 'Precio:',
                  )),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => placeForm.place!.departament = value,
                decoration: const InputDecoration(
                  hintText: 'Departamento',
                  labelText: 'Departamento:',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => placeForm.place!.city = value,
                decoration: const InputDecoration(
                  hintText: 'Ciudad',
                  labelText: 'Ciudad:',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => placeForm.place!.address = value,
                decoration: const InputDecoration(
                  hintText: 'Direccion',
                  labelText: 'Direccion:',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => placeForm.place!.neighborhood = value,
                decoration: const InputDecoration(
                  hintText: 'Barrio',
                  labelText: 'Barrio:',
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      );
}
