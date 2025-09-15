import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanDisiniPage extends StatefulWidget {
  const ScanDisiniPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScanDisiniPageState createState() => _ScanDisiniPageState();
}

class _ScanDisiniPageState extends State<ScanDisiniPage> {
  File? _image;
  bool _loading = false;
  String? _result;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _loading = true;
        _result = null;
      });
      await _scanImage(_image!);
    }
  }

  Future<void> _scanImage(File image) async {
    // Simulasi proses scan, ganti dengan API/ML model sesuai kebutuhan
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _loading = false;
      _result = "Nama Koleksi: Patung Ganesha\nDeskripsi: Patung batu dari abad ke-8, ditemukan di Jawa Tengah.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Koleksi Museum'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _image == null
                ? Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Text('Belum ada gambar')),
                  )
                : Image.file(_image!, height: 200),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loading ? null : _pickImage,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Scan Gambar Koleksi'),
            ),
            const SizedBox(height: 24),
            if (_loading) const CircularProgressIndicator(),
            if (_result != null)
              Card(
                margin: const EdgeInsets.only(top: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(_result!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}