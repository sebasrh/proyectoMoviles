import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        title: Text('SeeRooms'),
      ),
      body: const Center(
          child: CircularProgressIndicator(
        color: Colors.deepPurple,
      )),
    );
  }
}
