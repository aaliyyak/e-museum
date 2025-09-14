import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, size: 48, color: Colors.blueAccent),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(description, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Museum SMB II'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Selamat Datang di E-Museum Sultan Mahmud Badaruddin II',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          _buildCard(
            icon: Icons.info_outline,
            title: 'Tentang Museum',
            description:
                'Museum Sultan Mahmud Badaruddin II menyimpan berbagai benda peninggalan sejarah Palembang dan Kesultanan.',
          ),
          _buildCard(
            icon: Icons.help_outline,
            title: 'Cara Penggunaan',
            description:
                'Gunakan aplikasi ini untuk menjelajahi koleksi museum, membaca deskripsi benda, dan mencari informasi sejarah.',
          ),
          _buildCard(
            icon: Icons.search,
            title: 'Mulai Pencarian',
            description:
                'Cari benda peninggalan berdasarkan nama, kategori, atau periode sejarah dengan fitur pencarian di aplikasi.',
          ),
        ],
      ),
    );
  }
}