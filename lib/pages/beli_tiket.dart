import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

class BeliTiketPage extends StatefulWidget {
  const BeliTiketPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BeliTiketPageState createState() => _BeliTiketPageState();
}

class _BeliTiketPageState extends State<BeliTiketPage> {
  int jumlahTiket = 1;
  final int hargaTiket = 25000;
  bool showQR = false;
  String qrisData = '';

  final TextEditingController namaController = TextEditingController();
  final TextEditingController usiaController = TextEditingController();
  final TextEditingController kewarganegaraanController = TextEditingController();

  void _generateQRIS() {
    // Simulasi data QRIS (biasanya didapat dari backend/payment gateway)
    final uuid = const Uuid().v4();
    setState(() {
      qrisData =
          'QRIS|museum_smb2|order:$uuid|nama:${namaController.text}|usia:${usiaController.text}|kewarganegaraan:${kewarganegaraanController.text}|jumlah:$jumlahTiket|total:${jumlahTiket * hargaTiket}';
      showQR = true;
    });
  }

  @override
  void dispose() {
    namaController.dispose();
    usiaController.dispose();
    kewarganegaraanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beli Tiket Museum SMB II'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: usiaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Usia',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: kewarganegaraanController,
                decoration: const InputDecoration(
                  labelText: 'Kewarganegaraan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Harga Tiket: Rp$hargaTiket',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: jumlahTiket > 1
                        ? () => setState(() => jumlahTiket--)
                        : null,
                  ),
                  Text(
                    '$jumlahTiket',
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => jumlahTiket++),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Total: Rp${jumlahTiket * hargaTiket}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _generateQRIS,
                child: const Text('Bayar dengan QRIS'),
              ),
              const SizedBox(height: 32),
              if (showQR)
                Column(
                  children: [
                  const Text(
                    'Scan QRIS untuk pembayaran',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  QrImageView(
                    data: qrisData,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  ],
                )
                ,
                const SizedBox(height: 24),
                if (showQR)
                  ElevatedButton.icon(
                    onPressed: () async {
                      const snackBar = SnackBar(
                        content: Text('Tiket berhasil diunduh!'),
                        duration: Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      // Di sini Anda bisa menambahkan logika untuk menyimpan tiket ke galeri/file
                      // Misal: menggunakan screenshot, path_provider, atau share_plus
                    },
                    icon: const Icon(Icons.qr_code), // Ganti barcode QRIS jadi icon QR saja
                    label: const Text('Download Tiket'),
                  ),
                const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}