import 'package:flutter/material.dart';

class OrderTiketWidget extends StatelessWidget {
  final String namaTiket;
  final int jumlah;
  final double harga;
  final VoidCallback? onTambah;
  final VoidCallback? onKurang;

  const OrderTiketWidget({
    super.key,
    required this.namaTiket,
    required this.jumlah,
    required this.harga,
    this.onTambah,
    this.onKurang,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaTiket,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp${harga.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: onKurang,
                ),
                Text(
                  jumlah.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: onTambah,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}