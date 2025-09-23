// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'output.dart';

class VoiceInputPage extends StatefulWidget {
  const VoiceInputPage({super.key});

  @override
  State<VoiceInputPage> createState() => _VoiceInputPageState();
}

class _VoiceInputPageState extends State<VoiceInputPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) async {
        print('Status: $status');

        if (status == 'done' || status == 'notListening') {
          _stopListening();
        }
      },
      onError: (error) {
        print('Error: $error');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Terjadi kesalahan: ${error.errorMsg}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );

    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          if (mounted) {
            setState(() {
              _text = result.recognizedWords;
              _textController.text = result.recognizedWords;
            });
          }
        },
        localeId: 'id_ID',
        listenFor: const Duration(seconds: 10),
        pauseFor: const Duration(seconds: 2),
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mikrofon tidak tersedia.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _stopListening() {
    _speech.stop();
    if (mounted) {
      setState(() => _isListening = false);
    }
  }

  void _sendMessage() {
    if (_textController.text.trim().isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OutputPage(userInput: _textController.text.trim()),
      ),
    ).then((_) {
      _textController.clear();
      _text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Chatbot Museum",
          style: GoogleFonts.candal(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          // area chat kosong (bisa diisi list chat di masa depan)
          Expanded(
            child: Center(
              child: Text(
                "Mulai bertanya dengan suara atau ketik pesan",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ),

          // Input + Mic + Kirim
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                // Mic Button
                IconButton(
                  icon: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: _isListening ? Colors.blue : Colors.black54,
                  ),
                  onPressed: () {
                    if (_isListening) {
                      _stopListening();
                    } else {
                      _startListening();
                    }
                  },
                ),

                // TextField
                Expanded(
                  child: TextField(
                    controller: _textController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                    ),
                  ),
                ),

                // Send Button
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
