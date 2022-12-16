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
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              const SizedBox(height: 10),
              TextField(
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
                onChanged: (valor) {
                  _userName = valor;
                  print('El user name es $_userName');
                },
              ),
              const SizedBox(height: 10),
              TextField(
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
                onChanged: (valor) {
                  _password = valor;
                  print('La password es $_password');
                },
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
                    'Sign in',
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
                        builder: (context) => const RegisterPage());
                    Navigator.pushReplacement(context, route);
                  },
                  child: const Text(
                    'Register now',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  )),
              const Divider(
                height: 40.0,
              ),
              const Text('or sing in whit'),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.zero,
                  ),
                  elevation: MaterialStateProperty.all(5),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(
                    const Size(60.0, 60.0),
                  ),
                ),
                child: const Image(
                  image: NetworkImage(
                      'https://res.cloudinary.com/dgb26cwpx/image/upload/v1671159805/lagapi6lawcnvqugjo1f.png'),
                  width: 50.0,
                  height: 50.0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
