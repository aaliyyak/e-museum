import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'homepage.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late VideoPlayerController _controller1;

  @override
  void initState() {
    super.initState();
    // Initialize video controller
    _controller1 = VideoPlayerController.asset('assets/video/onboar.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller1.play();
      });
  }

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }

  Widget buildVideoSlide(VideoPlayerController controller, String title, String description) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.elliptical(80, 200),
              bottomRight: Radius.elliptical(600, 350),
            ),
            child: controller.value.isInitialized
                ? SizedBox(
                    width: double.infinity, // Memenuhi lebar layar
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
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
                _controller1,
                'Museum SMB II Palembang',
                'Selamat datang di aplikasi Museum Sultan Mahmud Badaruddin II Palembang. Jelajahi sejarah dan budaya.',
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Mulai Jelajah',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
