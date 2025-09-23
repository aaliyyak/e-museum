import 'package:e_museum_app/models/museum_collection.dart';
import 'package:flutter/material.dart';


class MuseumCollectionWidget extends StatelessWidget {
  final MuseumCollection collection;

  const MuseumCollectionWidget({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Koleksi
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                collection.gambar,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),

            // Nama Koleksi
            Text(
              collection.namaKoleksi,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),
            Text(
              collection.deskripsi,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red, size: 18),
                const SizedBox(width: 4),
                Text(
                  collection.lokasi,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Text(
              "Instruksi: ${collection.instruksiNavigasi}",
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
