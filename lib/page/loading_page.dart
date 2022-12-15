import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apartamentos"),
      ),
      body: Center(
          child: CircularProgressIndicator(
        color: Color(0xFFFFFB00),
      )),
    );
  }
}
