import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/login_page.dart';
import 'pages/attendance_page.dart';
import 'pages/admin_page.dart'; // Pastikan file ini sudah dibuat

// --- KONFIGURASI EMAIL ADMIN ---
// GANTI "email.kamu@gmail.com" DENGAN EMAIL ASLI YANG KAMU PAKAI DI HP!
const String adminEmail = "rayrayhan920@gmail.com";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inisialisasi Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Absensi Dago',

      // --- SETTING TEMA BIRU PUTIH ---
      theme: ThemeData(
        // Warna Dasar
        scaffoldBackgroundColor: Colors.white, // Latar belakang putih bersih
        primaryColor: Color(0xFF0D47A1), // Biru Tua (Professional Blue)
        // Skema Warna Material 3
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF0D47A1), // Bibit warna Biru
          primary: Color(0xFF0D47A1), // Warna utama komponen
          secondary: Colors.lightBlue, // Warna pelengkap
          surface: Colors.white, // Warna permukaan kartu/card
        ),

        // Style Tulisan (Typography)
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            color: Color(0xFF0D47A1),
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            color: Colors.grey[800],
          ), // Tulisan isi abu gelap biar enak baca
        ),

        // Style Tombol (Global)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0D47A1), // Tombol otomatis Biru
            foregroundColor: Colors.white, // Tulisan di tombol Putih
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ), // Sudut tombol agak melengkung
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),

        // Style AppBar (Header)
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF0D47A1), // Ikon & Judul warna Biru
          elevation: 0, // Hilangkan bayangan biar terlihat flat/clean
          centerTitle: true,
        ),

        useMaterial3: true,
      ),

      // STREAMBUILDER: Pengecek Status Login & Role Otomatis
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // 1. Sedang Loading (Cek status login)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          // 2. User Sedang Login
          if (snapshot.hasData) {
            User? user = snapshot.data;

            // --- LOGIC PEMISAH ADMIN VS USER ---
            // Cek apakah email yang login sama dengan email admin?
            if (user != null && user.email == adminEmail) {
              return AdminPage(); // Masuk ke Dashboard Admin
            } else {
              return AttendancePage(); // Masuk ke Absen Karyawan
            }
          } else {
            // 3. Belum Login
            return LoginPage();
          }
        },
      ),
    );
  }
}
