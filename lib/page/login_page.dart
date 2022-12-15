import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerooms/services/services.dart';
import 'page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _userName = '';
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
                'Login',
                style: TextStyle(fontFamily: 'IMFellEnglish', fontSize: 50.0),
              ),
              TextField(
                enableInteractiveSelection: false,
                autofocus: true,
                style: const TextStyle(fontFamily: 'Lato'),
                decoration: InputDecoration(
                    hintText: 'User name',
                    suffixIcon: const Icon(Icons.verified_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onChanged: (valor) {
                  _userName = valor;
                  print('El user name es $_userName');
                },
              ),
              const Divider(
                height: 18.0,
              ),
              TextField(
                enableInteractiveSelection: false,
                autofocus: true,
                obscureText: true,
                style: const TextStyle(fontFamily: 'Lato'),
                decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: const Icon(Icons.security_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onChanged: (valor) {
                  _password = valor;
                  print('La password es $_password');
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
                  onPressed: () async {
                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    if (await authService.loginUser(_userName, _password)) {
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
                                'Login Success!',
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
                                'Login Failure',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                        )));
                    }
                    /* final route = MaterialPageRoute(
                        builder: (context) => const OfferPage());
                    Navigator.pushReplacement(context, route); */
                    //Navigator.pushNamed(context, 'offer_page');
                  },
                  child: const Text(
                    'Sing in',
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
                        builder: (context) => const RegisterPage());
                    Navigator.pushReplacement(context, route);
                  },
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.black.withOpacity(0.1))),
                  child: const Text(
                    'Crear una cuenta nueva',
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
