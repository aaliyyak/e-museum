import 'package:flutter/material.dart';

class CariKoleksiPage extends StatefulWidget {
  const CariKoleksiPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CariKoleksiPageState createState() => _CariKoleksiPageState();
}

class _CariKoleksiPageState extends State<CariKoleksiPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allKoleksi = [
    'Keramik Dinasti Ming',
    'Tombak Sriwijaya',
    'Keris Palembang',
    'Lukisan Sultan Mahmud Badaruddin II',
    'Manik-manik Kuno',
    'Arca Buddha',
    'Perhiasan Emas',
    'Naskah Kuno',
    'Senjata Tradisional',
    'Kain Songket',
  ];
  List<String> _filteredKoleksi = [];

  @override
  void initState() {
    super.initState();
    _filteredKoleksi = _allKoleksi;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _filteredKoleksi = _allKoleksi
          .where((item) =>
              item.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Koleksi SMB II Palembang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Cari koleksi...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _filteredKoleksi.isEmpty
                  ? const Center(child: Text('Tidak ada koleksi ditemukan.'))
                  : ListView.builder(
                      itemCount: _filteredKoleksi.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_filteredKoleksi[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}