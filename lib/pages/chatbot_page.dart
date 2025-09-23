import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/museum_collection.dart';

class ChatbotPage extends StatefulWidget {
  final String namaPengguna;
  final MuseumCollection koleksi;

  const ChatbotPage({
    super.key,
    required this.namaPengguna,
    required this.koleksi,
  });

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  late FlutterTts _tts;

  @override
  void initState() {
    super.initState();
    _tts = FlutterTts();
    _speakResult();
  }

  Future<void> _speakResult() async {
    await _tts.setLanguage("id-ID");
    await _tts.setSpeechRate(0.9);

    String ucapan =
        "Hai ${widget.namaPengguna}, ${widget.koleksi.namaKoleksi} yang kamu cari ada di ${widget.koleksi.lokasi}. ${widget.koleksi.instruksiNavigasi}. Senang bertemu denganmu.";
    await _tts.speak(ucapan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chatbot Museum")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.koleksi.gambar, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(widget.koleksi.namaKoleksi,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.koleksi.deskripsi),
            const SizedBox(height: 12),
            Text("📍 Lokasi: ${widget.koleksi.lokasi}",
                style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text("🧭 Instruksi: ${widget.koleksi.instruksiNavigasi}"),
          ],
        ),
      ),
    );
  }
}
