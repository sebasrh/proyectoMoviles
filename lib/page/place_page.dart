import 'package:flutter/material.dart';
import 'package:seerooms/providers/place_provider.dart';
import 'package:seerooms/widget/place_image.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../services/services.dart';

class PlacePage extends StatelessWidget {
  const PlacePage({super.key});

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.deepPurple,
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        title: const Text('SeeRooms'),
      ),
      body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          child: Column(
            children: [
              Stack(
                children: [
                  PlaceImage(url: placeService.selectedPlace!.photo),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.deepPurple,
                      child: IconButton(
                        icon: const Icon(
                          Icons.photo,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          final picker = ImagePicker();

                          final PickedFile? pickedFile = await picker.getImage(
                              source: ImageSource.gallery, imageQuality: 100);

                          if (pickedFile == null) {
                            return;
                          }
                          placeService
                              .updateSelectedProductImage(pickedFile.path);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    right: 20,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.deepPurple,
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          final picker = ImagePicker();

                          final PickedFile? pickedFile = await picker.getImage(
                              source: ImageSource.camera, imageQuality: 100);

                          if (pickedFile == null) {
                            return;
                          }
                          placeService
                              .updateSelectedProductImage(pickedFile.path);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              _PlaceForm(),
              const SizedBox(height: 50),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.save_outlined),
        onPressed: () async {
          if (!placeForm.isValidForm()) return;

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Center(
                  child: Row(
                children: const [
                  Icon(
                    Icons.verified_user,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Apartament Created!',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )),
            )));

          final String? imageUrl = await placeService.uploadImage();

          if (imageUrl != null) placeForm.place!.photo = imageUrl;

          await placeService.saveOrCreatePlace(placeForm.place!);
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
          //autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              SwitchListTile.adaptive(
                  value: placeForm.place!.available,
                  tileColor: Colors.grey,
                  title: const Text('Disponible'),
                  activeColor: Colors.deepPurple,
                  onChanged: placeForm.updateAvailability),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: placeForm.place!.owner,
                cursorColor: Colors.deepPurple,
                decoration: InputDecoration(
                    hintText: 'Nombre del propietario',
                    label: const Text('Nombre del propietario'),
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onChanged: (value) {
                  placeForm.place!.owner = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: placeForm.place!.numberPhone,
                onChanged: (value) => placeForm.place!.numberPhone = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                cursorColor: Colors.deepPurple,
                decoration: InputDecoration(
                    hintText: 'Número de celular',
                    label: const Text('Número de celular'),
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: placeForm.place!.price,
                onChanged: (value) => placeForm.place!.price = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                cursorColor: Colors.deepPurple,
                decoration: InputDecoration(
                    hintText: 'Precio',
                    label: const Text('Precio'),
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: placeForm.place!.departament,
                onChanged: (value) => placeForm.place!.departament = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
                cursorColor: Colors.deepPurple,
                decoration: InputDecoration(
                    hintText: 'Departamento',
                    label: const Text('Departamento'),
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: placeForm.place!.city,
                onChanged: (value) => placeForm.place!.city = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
                cursorColor: Colors.deepPurple,
                decoration: InputDecoration(
                    hintText: 'Ciudad',
                    label: const Text('Ciudad'),
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: placeForm.place!.address,
                onChanged: (value) => placeForm.place!.address = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
                cursorColor: Colors.deepPurple,
                decoration: InputDecoration(
                    hintText: 'Dirección',
                    label: const Text('Dirección'),
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: placeForm.place!.neighborhood,
                onChanged: (value) => placeForm.place!.neighborhood = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
                cursorColor: Colors.deepPurple,
                decoration: InputDecoration(
                    hintText: 'Barrio',
                    label: const Text('Barrio'),
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30)),
      );
}
