import 'package:e_museum_app/pages/beli_tiket.dart';
import 'package:e_museum_app/pages/cari_koleksi.dart';
import 'package:e_museum_app/pages/scan_disini.dart';
import 'package:e_museum_app/widgets/banner_widgets.dart';
import 'package:e_museum_app/widgets/event_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'museum.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Fungsi card kecil untuk fitur
  Widget _buildCard({
    required String imagePath,
    required String title,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 90,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Gambar p3.png kiri atas tetap di posisi semula
            Positioned(
              top: 10,
              left: -240,
              child: Image.asset(
                'assets/images/p3.png',
                width: 370,
                height: 170,
              ),
            ),
           

            // Konten utama layar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo circular di tengah atas
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: SizedBox(
                      width: 90,
                      height: 60,
                      child: Image.asset('assets/icon/logo.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                // Teks di atas banner
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Museum Kota Palembang",
                        style: GoogleFonts.candal(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Sultan Mahmud Badaruddin II",
                        style: GoogleFonts.faustina(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                const TicketBanner(),
                const SizedBox(height: 10),

                // Judul Fitur
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4),
                  child: Text(
                    'Fitur',
                    style: GoogleFonts.candal(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

                // Row 1 dengan 4 kolom card fitur
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildCard(
                          imagePath: 'assets/vectors/4.png',
                          title: 'Museum SMB II',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const MuseumPage()));
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: _buildCard(
                          imagePath: 'assets/vectors/17a.png',
                          title: 'Cari\nKoleksi',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CariKoleksiPage()));
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: _buildCard(
                          imagePath: 'assets/vectors/14a.png',
                          title: 'Scan\nDisini',
                          onTap: () {
                            //Aksi saat card ditekan
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ScanDisiniPage()));
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: _buildCard(
                            imagePath: 'assets/vectors/13a.png',
                            title: 'Beli\nTiket', onTap: () {
                              //Aksi saat card ditekan
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const BeliTiketPage()));
                            },),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Judul Event
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(
                    'Event',
                    style: GoogleFonts.candal(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Event widget horizontal scroll
                const EventWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
