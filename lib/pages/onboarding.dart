import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'homepage.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller1;
  late AnimationController _micAnimationController;
  late Animation<Color?> _micColorAnimation;
  late Animation<double> _micScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Video controller
    _controller1 = VideoPlayerController.asset('assets/video/onboar.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller1.play();

        _controller1.addListener(() {
          if (_controller1.value.isInitialized &&
              _controller1.value.position >= _controller1.value.duration &&
              !_micAnimationController.isAnimating) {
            // Mulai animasi mic
            _micAnimationController.repeat(reverse: true);
            Future.delayed(const Duration(seconds: 3), () {
              _micAnimationController.stop();
              _micAnimationController.reset();
            });
          }
        });
      });

    // AnimationController untuk mic (kedip + goyang)
    _micAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Color tween mic: deepOrange <-> white (kedip)
    _micColorAnimation = ColorTween(
      begin: Colors.deepOrange,
      end: Colors.white,
    ).animate(_micAnimationController);

    // Scale tween mic: 1.0 <-> 1.2 (goyang)
    _micScaleAnimation = Tween<double>(begin: 1.0, end: 1.2)
        .animate(CurvedAnimation(parent: _micAnimationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller1.dispose();
    _micAnimationController.dispose();
    super.dispose();
  }

  Widget buildVideoSlide(VideoPlayerController controller, String title, String description) {
    return Column(
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
              child: Row(
                children: [
                  // Mic kecil dengan animasi kedip + goyang
                  AnimatedBuilder(
                    animation: _micAnimationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _micScaleAnimation.value,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: _micColorAnimation.value,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.mic, color: Colors.white),
                            onPressed: () {
                              // Tambahkan fungsi TTS di sini
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  // Box Next besar
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
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
