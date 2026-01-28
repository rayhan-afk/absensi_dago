import 'package:flutter/material.dart';
import 'package:absensi_dago/services/auth_service.dart'; // Pastikan path ini benar

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Mengambil warna dari Theme yang sudah diset di main.dart
    final primaryColor = Theme.of(context).primaryColor; // 0xFF0D47A1

    return Scaffold(
      // Background Putih Bersih (Sesuai tema main.dart)
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 1),

              // --- BAGIAN HEADER ---
              Column(
                children: [
                  Text(
                    "Absensi Dago",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: primaryColor, // Warna Biru Tua
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Welcome back, Ohana!\nAttendance made easy.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ],
              ),

              Spacer(flex: 1),

              // --- PENGGANTI GAMBAR STITCH ---
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blue[50], // Biru sangat muda
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.apartment_rounded, // Ikon Gedung Kantor
                  size: 100,
                  color: primaryColor,
                ),
              ),

              Spacer(flex: 1),

              // --- TOMBOL LOGIN ---
              _isLoading
                  ? CircularProgressIndicator()
                  : Container(
                      width: double.infinity,
                      height: 56, // Tinggi tombol disamakan dengan HTML (h-14)
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50), // Rounded Full
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() => _isLoading = true);

                          // Proses Login
                          final user = await AuthService.signInWithGoogle();

                          // PERBAIKAN: Cek apakah halaman masih ada sebelum setState
                          if (mounted) {
                            setState(() => _isLoading = false);
                          }

                          // Jika gagal login & halaman masih ada, tampilkan pesan
                          if (user == null && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Login dibatalkan")),
                            );
                          }

                          // Jika sukses, Navigasi otomatis dihandle oleh StreamBuilder di main.dart
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Background Putih
                          foregroundColor: Colors.black87, // Teks Hitam
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(
                              color: Colors.grey.shade200,
                            ), // Border halus
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Logo Google
                            Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
                              height: 24,
                              width: 24,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.g_mobiledata, size: 24),
                            ),
                            SizedBox(width: 12),
                            Text(
                              "Masuk dengan Google",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

              SizedBox(height: 24),

              // --- FOOTER (Secure Access) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, size: 16, color: Colors.grey[500]),
                  SizedBox(width: 6),
                  Text(
                    "Secure Corporate Access",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              // Trouble Logging in
              TextButton(
                onPressed: () {},
                child: Text(
                  "Trouble logging in?",
                  style: TextStyle(
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
