import 'package:flutter/material.dart';

import 'package:seerooms/models/models.dart';

class PlaceCard extends StatelessWidget {
  final PlaceModel place;
  const PlaceCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(place.photos![0]),
            _PlaceDetails(
              ciudad: "Ciudad: ${place.city}",
              precio: "Precio: ${place.price}",
            ),
            if (!place.available)
              Positioned(
                top: 0,
                left: 0,
                child: _NotAvailable(),
              ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ]);
}

class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No disponible',
            style: TextStyle(fontSize: 20, color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      width: 100,
      height: 60,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 165, 97),
      ),
    );
  }
}

class _PlaceDetails extends StatelessWidget {
  final String ciudad;
  final String precio;
  const _PlaceDetails({required this.ciudad, required this.precio});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      height: 70,
      color: const Color(0xFFFFFB00),
      child: Column(
        children: [
          Text(
            ciudad,
            style: TextStyle(fontSize: 20, color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            precio,
            style: TextStyle(fontSize: 20, color: Colors.black),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage(this.url);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(url!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
