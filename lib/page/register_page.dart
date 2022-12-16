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
  String _password2 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 100.0,
        ),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('images/seerooms.png'),
                width: 150.0,
                height: 150.0,
              ),
              const SizedBox(height: 50),
              const Text(
                'Register account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  _email = value;
                  print('El email es $_email');
                },
                style: const TextStyle(fontFamily: 'Lato'),
                decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon:
                        const Icon(Icons.email_outlined, color: Colors.grey),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  _password = value;
                  print('El password es $_password');
                },
                obscureText: true,
                style: const TextStyle(fontFamily: 'Lato'),
                decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon:
                        const Icon(Icons.key_outlined, color: Colors.grey),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  _password2 = value;
                  print('El password es $_password');
                },
                obscureText: true,
                style: const TextStyle(fontFamily: 'Lato'),
                decoration: InputDecoration(
                    hintText: 'Repeat password',
                    prefixIcon:
                        const Icon(Icons.key_outlined, color: Colors.grey),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 60.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                      shape: const StadiumBorder()),
                  onPressed: () async {
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (_password == _password2) {
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
                    }

                    // ignore: use_build_context_synchronously
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                    'Already have an account?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
