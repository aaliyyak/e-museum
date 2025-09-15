import 'package:flutter/material.dart';

class MuseumPage extends StatelessWidget {
  const MuseumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Museum SMB II'),
      ),
      body: const Center(
        child: Text(
          'Selamat datang di Museum SMB II',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
