import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/koleksi_models.dart';
import '../models/koleksi_list.dart';

class OutputPage extends StatefulWidget {
  final String userInput;

  const OutputPage({super.key, required this.userInput});

  @override
  State<OutputPage> createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  final FlutterTts flutterTts = FlutterTts();
  Koleksi? koleksiDitemukan;
  String namaPengguna = "";

  @override
  void initState() {
    super.initState();
    _processInput(widget.userInput);
  }

  void _processInput(String input) {
    // Ambil nama pengguna dari kalimat "hai aku ..."
    if (input.toLowerCase().contains("aku")) {
      var parts = input.split("aku");
      if (parts.length > 1) {
        namaPengguna = parts[1].split(",")[0].trim();
      }
    }

    // Cari koleksi berdasarkan keywords
    for (var koleksi in koleksiList) {
      for (var keyword in koleksi.keywords) {
        if (input.toLowerCase().contains(keyword.toLowerCase())) {
          setState(() {
            koleksiDitemukan = koleksi;
          });
          _speakOutput();
          return;
        }
      }
    }

    // Kalau tidak ditemukan
    setState(() {
      koleksiDitemukan = null;
    });
    _speakOutput();
  }

  Future<void> _speakOutput() async {
    String sentence;

    if (koleksiDitemukan == null) {
      sentence = "Maaf $namaPengguna, koleksi yang kamu cari belum ada di database.";
    } else {
      sentence =
          "Hai $namaPengguna, ${koleksiDitemukan!.title} berada di ${koleksiDitemukan!.lokasi}. "
          "Silahkan ${koleksiDitemukan!.instruksi}. Senang bertemu denganmu.";
    }

    await flutterTts.setLanguage("id-ID");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(sentence);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hasil Pencarian Koleksi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: koleksiDitemukan == null
            ? const Center(
                child: Text(
                  "Koleksi tidak ditemukan 😢",
                  style: TextStyle(fontSize: 18),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Halo $namaPengguna 👋",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    koleksiDitemukan!.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Image.asset(
                    koleksiDitemukan!.imagePath,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Lokasi: ${koleksiDitemukan!.lokasi}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    koleksiDitemukan!.deskripsi,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "🧭 Instruksi Navigasi:",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    koleksiDitemukan!.instruksi,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
      ),
    );
  }
}
