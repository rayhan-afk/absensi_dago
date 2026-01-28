import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/login_page.dart';
import 'pages/attendance_page.dart'; // Pastikan kamu sudah punya file ini dari diskusi sebelumnya

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
      theme: ThemeData(primarySwatch: Colors.blue),

      // STREAMBUILDER: Pengecek Status Login Otomatis
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            ); // Loading pas baru buka
          }

          if (snapshot.hasData) {
            // User SUDAH Login -> Masuk ke Aplikasi Utama
            return AttendancePage();
          } else {
            // User BELUM Login -> Tampilkan Halaman Login
            return LoginPage();
          }
        },
      ),
    );
  }
}
