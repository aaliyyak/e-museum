import 'dart:typed_data';
import 'dart:async';
import 'package:e_museum_app/pages/penggunaspeech.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sound_stream/sound_stream.dart';

import '../main.dart';
import 'homepage.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  CameraController? _cameraFront;
  Uint8List? _lastFrameFront;

  List<CameraDescription>? cameras;

  bool _isMovingFront = false;
  bool _isSoundDetected = false;

  final RecorderStream _recorder = RecorderStream();
  StreamSubscription<List<int>>? _audioSub;

  // ===== Untuk animasi berkedip ikon kamera =====
  late AnimationController _blinkController;
  late Animation<Color?> _cameraColorAnimation;

  @override
  void initState() {
    super.initState();

    // ===== Video =====
    _controller = VideoPlayerController.asset('assets/video/onboar.mp4')
      ..initialize().then((_) => setState(() {}));

    // ===== Audio =====
    _initAudio();

    // ===== Kamera depan =====
    _initCamerasAndFront();

    // ===== Animasi berkedip kamera =====
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _cameraColorAnimation = ColorTween(begin: Colors.grey, end: Colors.red)
        .animate(_blinkController)
      ..addListener(() {
        setState(() {});
      });
    _blinkController.repeat(reverse: true);
  }

  Future<void> _initCamerasAndFront() async {
    cameras = await availableCameras();
    await _initCameraFront();
  }

  // ================= Camera Front =================
  Future<void> _initCameraFront() async {
    var status = await Permission.camera.request();
    if (!status.isGranted) return;
    if (cameras == null || cameras!.isEmpty) return;

    try {
      _cameraFront = CameraController(
        cameras!
            .firstWhere((c) => c.lensDirection == CameraLensDirection.front),
        ResolutionPreset.low,
        enableAudio: false,
      );
      await _cameraFront!.initialize();
      _cameraFront!.startImageStream((image) => _processFrame(image));
      print("📷 Kamera depan siap");
    } catch (e) {
      print("❌ Kamera depan gagal: $e");
    }
  }

  void _processFrame(CameraImage image) {
    Uint8List currentFrame = image.planes[0].bytes;

    if (_lastFrameFront != null) {
      int diff = 0;
      for (int i = 0; i < currentFrame.length; i += 50) {
        if ((currentFrame[i] - _lastFrameFront![i]).abs() > 15) diff++;
      }

      bool detected = diff > 300;
      if (detected != _isMovingFront) {
        _isMovingFront = detected;
        print(_isMovingFront
            ? "👤 Gerakan depan terdeteksi"
            : "☀️ Tidak ada gerakan depan");
        _updateVideoState();
        setState(() {});
      }
    }

    _lastFrameFront = currentFrame;
  }

  // ================= Audio detection =================
  Future<void> _initAudio() async {
    var micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) return;

    await _recorder.initialize();
    await _recorder.start();

    _audioSub = _recorder.audioStream.listen((data) {
      double avg =
          data.map((b) => b.abs()).reduce((a, b) => a + b) / data.length;
      bool soundDetected = avg > 5;
      if (soundDetected != _isSoundDetected) {
        _isSoundDetected = soundDetected;
        _updateVideoState();
        setState(() {});
      }
    });
  }

  // ================= Update Video =================
  void _updateVideoState() {
    if (!_controller.value.isInitialized) return;

    if ((_isMovingFront || _isSoundDetected) && !_controller.value.isPlaying) {
      _controller.play();
      print("▶ Video PLAY");
    } else if (!_isMovingFront &&
        !_isSoundDetected &&
        _controller.value.isPlaying) {
      _controller.pause();
      print("⏸ Video PAUSE");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _cameraFront?.dispose();
    _audioSub?.cancel();
    _recorder.stop();
    _blinkController.dispose();
    super.dispose();
  }

  // ================= Build Video Slide with Indicators =================
  Widget buildVideoSlide(
      VideoPlayerController controller, String title, String description) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.elliptical(80, 250),
                  bottomRight: Radius.elliptical(870, 300),
                ),
                child: controller.value.isInitialized
                    ? SizedBox(
                        width: double.infinity,
                        child: AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        // ===== Indikator kamera di pojok kanan atas =====
        Positioned(
          top: 16,
          right: 16,
          child: Icon(
            Icons.camera_alt,
            color:
                _isMovingFront ? Color.fromARGB(228, 228, 19, 4) : Colors.grey,
            size: 18,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: buildVideoSlide(
                _controller,
                'Museum SMB II Palembang',
                'Selamat datang di Museum Sultan Mahmud Badaruddin II Palembang. Jelajahi sejarah dan budaya.',
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: [
                  // ===== Button Mic di kiri bawah =====
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VoiceInputPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                            181, 255, 205, 210), // <- putih
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: Colors.white,
                            width: 2), // outline merah biar matching
                      ),
                      child: const Icon(
                        Icons.mic,
                        color: Color.fromARGB(244, 163, 13, 2), // <- mic merah
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  // ===== Next Button di kanan bawah =====
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(237, 189, 83, 37),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
