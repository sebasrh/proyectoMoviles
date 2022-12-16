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
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.deepPurple,
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        title: const Text('SeeRooms'),
      ),
      body: SingleChildScrollView(
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
                      placeService.updateSelectedProductImage(pickedFile.path);
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
                      placeService.updateSelectedProductImage(pickedFile.path);
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

          final String? imageUrl = await placeService.uploadImage();

          if (imageUrl != null) {
            placeForm.place!.photo = imageUrl;
          } else {
            placeForm.place!.photo =
                'http://res.cloudinary.com/dgb26cwpx/image/upload/v1671170908/ko6jupcznbcd2e395msh.png';
          }

          await placeService.saveOrCreatePlace(placeForm.place!);

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
              const SizedBox(height: 40),
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
