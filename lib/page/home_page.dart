import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerooms/models/models.dart';
import 'package:seerooms/page/loading_page.dart';
import 'package:seerooms/services/services.dart';
import 'package:seerooms/widget/place_card.dart';
import 'package:seerooms/page/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final placeService = Provider.of<PlaceService>(context);

    if (placeService.isLoading) return LoadingPage();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFB00),
        titleTextStyle:
            const TextStyle(fontFamily: 'Lato', color: Colors.black),
        title: Text('SeeRooms'),
        leading: IconButton(
          icon: const Icon(Icons.login_outlined, color: Colors.black),
          onPressed: () {
            final route =
                MaterialPageRoute(builder: (context) => const LoginPage());
            Navigator.pushReplacement(context, route);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: placeService.places.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            placeService.selectedPlace = placeService.places[index].copy();
            Navigator.pushNamed(context, 'offer_page');
          },
          child: PlaceCard(place: placeService.places[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFFB00),
        onPressed: () {
          placeService.selectedPlace = new PlaceModel(
              address: '',
              available: true,
              city: '',
              departament: '',
              neighborhood: '',
              numberPhone: '',
              owner: '',
              price: '');
          Navigator.pushNamed(context, 'place_page');
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
