import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://s3.amazonaws.com/imagenesprof.fincaraiz.com.co/OVFR_COL/2021/2/8/2948004_111_35.jpg',
      'https://s3.amazonaws.com/imagenesprof.fincaraiz.com.co/OVFR_COL/2021/2/8/2948004_775_31.jpg',
      'https://s3.amazonaws.com/imagenesprof.fincaraiz.com.co/OVFR_COL/2021/2/8/2948004_939_22.jpg'
    ];
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item, fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Seerooms',
              style: TextStyle(fontFamily: 'Lato', color: Colors.black)),
          backgroundColor: Color(0xFFFFFB00),
        ),
        body: Column(
          children: [
            Container(
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: imageSliders,
              ),
            ),
            const SectionTitle(title: 'Hospedajes en Tuluá'),
            const Divider(
              height: 18.0,
            ),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Tuluá, Valle del cauca',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Lato',
                  fontSize: 17.0,
                ),
              ),
            ),
            const Divider(
              height: 18.0,
            ),
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Esta hermosa es ideal para descansar \n Con todas sus áreas disponibles sala \n Comedor \n Cocina \n Garage  \n Patio con hermoso jardín \n Cerca  supermercado ",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Lato',
                  fontSize: 20.0,
                ),
              ),
            ),
            const Divider(
              height: 18.0,
            ),
            Text("valor por noche 200000(COP)"),
            const Divider(
              height: 18.0,
            ),
            const Text(
              'Calvin Cordozar (Alfitrion)',
              style: TextStyle(fontFamily: 'IMFellEnglish', fontSize: 20.0),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: (){
                  Navigator.pushNamed(context, 'rent_page');
                },
                child: const Text(
                  'Hacer Reserva',
                  style: TextStyle(
                    color: Color(0xFFFFFB00),
                    fontFamily: 'Lato',
                    fontSize: 30.0,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}


class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          // ignore: prefer_const_constructors
          style: TextStyle(
              fontFamily: "Lato",
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
