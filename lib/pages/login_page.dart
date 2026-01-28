import 'package:flutter/material.dart';
import 'package:absensi_dago/services/auth_service.dart'; // Sesuaikan nama paketmu
import 'package:absensi_dago/pages/attendance_page.dart'; // Pastikan path ini benar nanti

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo atau Gambar (Opsional)
            Icon(Icons.access_time_filled, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              "Absensi Dago",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),

            // Tombol Login
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      elevation: 2,
                    ),
                    icon: Image.network(
                      'https://img.icons8.com/color/48/000000/google-logo.png', // Ikon Google
                      height: 24,
                    ),
                    label: Text("Masuk dengan Google"),
                    onPressed: () async {
                      setState(() => _isLoading = true);

                      final user = await AuthService.signInWithGoogle();

                      setState(() => _isLoading = false);

                      if (user != null) {
                        // Berhasil Login -> Pindah ke Halaman Absen
                        // (Nanti kita ganti logic ini di main.dart biar otomatis)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Selamat datang, ${user.displayName}!",
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Gagal Login / Dibatalkan")),
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
