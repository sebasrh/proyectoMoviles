import 'package:flutter/material.dart';
import 'package:seerooms/providers/place_provider.dart';
import 'package:seerooms/widget/place_image.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class PlacePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlacePage place;
    final placeService = Provider.of<PlaceService>(context);

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              PlaceImage(),
              Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () {
                      //await placeService.saveOrCreatePlace(placeForm.place);
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
        onPressed: () {},
      ),
    );
  }
}

class _PlaceForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final placeForm = Provider.of<PlaceFormProvider>(context);
    //final place = placeForm.place;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          //skey: placeForm.formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                //onChanged: (value) => place.owner = value,
                decoration: const InputDecoration(
                  hintText: 'Nombre del propietario',
                  labelText: 'Nombre del propietario:',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                //onChanged: (value) => place.numberPhone = value,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Numero de celular',
                  labelText: 'Numero de celular:',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                  //onChanged: (value) => place.price = value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Precio del hospedaje',
                    labelText: 'Precio:',
                  )),
              const SizedBox(height: 10),
              TextFormField(
                //onChanged: (value) => place.departament = value,
                decoration: const InputDecoration(
                  hintText: 'Departamento',
                  labelText: 'Departamento:',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                //onChanged: (value) => place.city = value,
                decoration: const InputDecoration(
                  hintText: 'Ciudad',
                  labelText: 'Ciudad:',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                //onChanged: (value) =>  = value,
                decoration: const InputDecoration(
                  hintText: 'Direccion',
                  labelText: 'Direccion:',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                //onChanged: (value) => place.neighborhood = value,
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
