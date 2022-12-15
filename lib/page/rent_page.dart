import 'package:flutter/material.dart';

import '../models/models.dart';

class RentPage extends StatefulWidget {
  const RentPage({super.key});

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  String _dateOn = '';
  String _dateOff = '';
  String _name = '';
  String _numberPhone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFB00),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 90.0,
        ),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(
                height: 180.0,
              ),
              const Text(
                'Formulario para rentar',
                style: TextStyle(fontFamily: 'IMFellEnglish', fontSize: 30.0),
              ),
              TextField(
                enableInteractiveSelection: false,
                autofocus: true,
                style: const TextStyle(fontFamily: 'Lato'),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Fecha de inicio de hospedaje',
                    suffixIcon: const Icon(Icons.date_range),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onChanged: (valor) {
                  _dateOn = valor;
                  print('Fecha de inicio de hospedaje $_dateOn');
                },
              ),
              const Divider(
                height: 18.0,
              ),
              TextField(
                enableInteractiveSelection: false,
                autofocus: true,
                style: const TextStyle(fontFamily: 'Lato'),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Fecha de inicio de hospedaje',
                    suffixIcon: const Icon(Icons.date_range_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onChanged: (valor) {
                  _dateOff = valor;
                  print('Fecha de inicio de hospedaje $_dateOff');
                },
              ),
              const Divider(
                height: 18.0,
              ),
              TextField(
                enableInteractiveSelection: false,
                autofocus: true,
                style: const TextStyle(fontFamily: 'Lato'),
                decoration: InputDecoration(
                    hintText: 'Nombre Completo',
                    suffixIcon: const Icon(Icons.supervised_user_circle),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onChanged: (valor) {
                  _name = valor;
                  print('Fecha de inicio de hospedaje $_name');
                },
              ),
              const Divider(
                height: 18.0,
              ),
              TextField(
                enableInteractiveSelection: false,
                autofocus: true,
                style: const TextStyle(fontFamily: 'Lato'),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Telefono',
                    suffixIcon: const Icon(Icons.perm_contact_calendar_sharp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onChanged: (valor) {
                  _numberPhone = valor;
                  print('Fecha de inicio de hospedaje $_numberPhone');
                },
              ),
              const Divider(
                height: 18.0,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    if (_dateOff != "" &&
                        _dateOn != "" &&
                        _name != "" &&
                        _numberPhone != "") {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            //title: const Text('Basic dialog title'),
                            title: const Text(
                                'El anfitrión se comunicará de forma\n'
                                ' oportuna para concretar detalles.\n'),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Ok'),
                                onPressed: () {
                                  
                                  Navigator.pushNamed(context, 'home_page');
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
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
                                Icons.sms_failed,
                                color: Colors.red,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Digite todos los campos!',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                        )));
                    }
                  },
                  child: const Text(
                    'Reservar',
                    style: TextStyle(
                      color: Color(0xFFFFFB00),
                      fontFamily: 'Lato',
                      fontSize: 30.0,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
