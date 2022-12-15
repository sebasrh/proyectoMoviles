import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerooms/services/services.dart';

import 'page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email = '';
  String _password = '';
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
              const CircleAvatar(
                radius: 100.0,
                backgroundImage: AssetImage('images/logo.png'),
              ),
              const Text(
                'Crear cuenta',
                style: TextStyle(fontFamily: 'IMFellEnglish', fontSize: 50.0),
              ),
              TextField(
                onChanged: (value) {
                  _email = value;
                  print('El email es $_email');
                },
                enableInteractiveSelection: false,
                autofocus: true,
                style: const TextStyle(fontFamily: 'Lato'),
                decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: const Icon(Icons.verified_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onSubmitted: (valor) {},
              ),
              const Divider(
                height: 18.0,
              ),
              TextField(
                onChanged: (value) {
                  _password = value;
                  print('El password es $_password');
                },
                enableInteractiveSelection: false,
                autofocus: true,
                obscureText: true,
                style: const TextStyle(fontFamily: 'Lato'),
                decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: const Icon(Icons.security_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onSubmitted: (valor) {},
              ),
              const Divider(
                height: 18.0,
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
                  onPressed: () async {
                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    if (await authService.createUser(_email, _password)) {
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
                                'User Created!',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                        )));

                      final route = MaterialPageRoute(
                          builder: (context) => const HomePage());
                      Navigator.pushReplacement(context, route);
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
                    // ignore: use_build_context_synchronously
                  },
                  child: const Text(
                    'Crear',
                    style: TextStyle(
                      color: Color(0xFFFFFB00),
                      fontFamily: 'Lato',
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                  onPressed: () {
                    final route = MaterialPageRoute(
                        builder: (context) => const LoginPage());
                    Navigator.pushReplacement(context, route);
                  },
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.black.withOpacity(0.1))),
                  child: const Text(
                    '¿Ya tienes una cuenta?',
                    style: TextStyle(
                        fontSize: 18, fontFamily: 'Lato', color: Colors.black),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
