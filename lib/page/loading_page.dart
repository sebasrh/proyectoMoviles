import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFB00),
        titleTextStyle:
            const TextStyle(fontFamily: 'Lato', color: Colors.black),
        title: Text('SeeRooms'),
      ),
      body: Center(
          child: CircularProgressIndicator(
        color: Color(0xFFFFFB00),
      )),
    );
  }
}
