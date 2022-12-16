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

    if (placeService.isLoading) return const LoadingPage();

    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.deepPurple,
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        title: const Text('SeeRooms'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              final route =
                  MaterialPageRoute(builder: (context) => const LoginPage());
              Navigator.pushReplacement(context, route);
            },
            child: const Text(
              'Sign out',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: placeService.places.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            placeService.selectedPlace = placeService.places[index].copy();
            Navigator.pushNamed(context, 'place_page');
          },
          child: PlaceCard(place: placeService.places[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          placeService.selectedPlace = PlaceModel(
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
