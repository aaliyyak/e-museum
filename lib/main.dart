import 'package:e_museum_app/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

// simpan kamera yang aktif (misal hanya depan)
CameraDescription? activeCamera;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // WAJIB sebelum plugin

  // ambil semua kamera
  List<CameraDescription> allCameras = await availableCameras();

  // pilih kamera depan saja
  activeCamera = allCameras.firstWhere(
    (camera) => camera.lensDirection == CameraLensDirection.front,
    orElse: () => allCameras.first, // fallback kalau depan tidak ada
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Museum App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
