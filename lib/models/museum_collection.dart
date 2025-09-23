import 'package:flutter/material.dart';

class MuseumCollection {
  final String kodeGambar;
  final String gambar;
  final String namaKoleksi;
  final String deskripsi;
  final String lokasi;
  final String instruksiNavigasi;

  MuseumCollection({
    required this.kodeGambar,
    required this.gambar,
    required this.namaKoleksi,
    required this.deskripsi,
    required this.lokasi,
    required this.instruksiNavigasi,
  });
}

// ✅ Daftar koleksi museum
final List<MuseumCollection> koleksiMuseum = [
  MuseumCollection(
    kodeGambar: "ALB001",
    gambar: "assets/images/event1.png",
    namaKoleksi: "Lukisan Albert",
    deskripsi: "Lukisan karya Albert dengan gaya realis klasik.",
    lokasi: "Lantai 1, Galeri A",
    instruksiNavigasi:
        "Naik ke lantai 1, maju sekitar 19 langkah, lalu lihat ke sebelah kiri.",
  ),
  MuseumCollection(
    kodeGambar: "PAT002",
    gambar: "assets/images/event2.png",
    namaKoleksi: "Patung Liberty Mini",
    deskripsi: "Replika kecil dari Patung Liberty, hadiah persahabatan.",
    lokasi: "Lantai 2, dekat tangga utama",
    instruksiNavigasi:
        "Naik ke lantai 2, berjalan ke arah tangga utama, patung berada di dekat sisi kanan.",
  ),
  MuseumCollection(
    kodeGambar: "VAS003",
    gambar: "assets/images/event2.png",
    namaKoleksi: "Vas Keramik Dinasti Ming",
    deskripsi: "Vas keramik asli dari Dinasti Ming abad ke-15.",
    lokasi: "Lantai 3, ruang pamer keramik",
    instruksiNavigasi:
        "Naik ke lantai 3, belok ke ruang pamer keramik, koleksi ada di tengah ruangan.",
  ),
];
