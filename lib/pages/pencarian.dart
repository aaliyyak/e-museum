import 'package:e_museum_app/models/museum_collection.dart';
import 'package:e_museum_app/widgets/koleksi_widget.dart';
import 'package:flutter/material.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cari Koleksi Museum")),
      body: ListView.builder(
        itemCount: koleksiMuseum.length,
        itemBuilder: (context, index) {
          return MuseumCollectionWidget(collection: koleksiMuseum[index]);
        },
      ),
    );
  }
}
