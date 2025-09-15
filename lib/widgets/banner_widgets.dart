import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TicketBanner extends StatefulWidget {
  const TicketBanner({super.key});

  @override
  State<TicketBanner> createState() => _TicketBannerState();
}

class _TicketBannerState extends State<TicketBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Hanya 2 video: Harga Tiket dan Jam Operasional
  final List<String> _videos = [
    "assets/video/boy.mp4",
    "assets/video/girl.mp4",
  ];

  final List<String> _titles = [
    "Harga Tiket",
    "Jam Operasional",
  ];

  final List<VideoPlayerController> _videoControllers = [];

  @override
  void initState() {
    super.initState();

    for (var path in _videos) {
      final videoController = VideoPlayerController.asset(path)
        ..setLooping(true); // loop video agar otomatis ulang

      videoController.initialize().then((_) {
        setState(() {});
        if (_videos.indexOf(path) == 0) {
          videoController.play();
        }
      });

      _videoControllers.add(videoController);
    }
  }

  @override
  void dispose() {
    for (var vc in _videoControllers) {
      vc.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: Stack(
            children: [
              // PageView video manual
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                bottom: 0,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _videos.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                    for (int i = 0; i < _videoControllers.length; i++) {
                      if (i == index) {
                        _videoControllers[i].seekTo(Duration.zero);
                        _videoControllers[i].play();
                      } else {
                        _videoControllers[i].pause();
                      }
                    }
                  },
                  itemBuilder: (context, index) {
                    final videoController = _videoControllers[index];
                    return Card(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: videoController.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: videoController.value.aspectRatio,
                              child: VideoPlayer(videoController),
                            )
                          : const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),

              // Judul tetap di atas, posisi tidak berubah
              Positioned(
                top: 5,
                left: 14,
                right: 14,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade700,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    _titles[_currentPage],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // dot indikator tetap
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _videos.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 16 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? Colors.red.shade700
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
