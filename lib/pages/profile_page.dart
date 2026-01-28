import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:absensi_dago/services/auth_service.dart'; // Sesuaikan path jika beda

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.grey[50], // Background agak abu
      appBar: AppBar(
        title: Text("Profil Saya"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // Teks hitam
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),

            // --- FOTO PROFIL BESAR ---
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blue[50],
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : null,
                      child: user?.photoURL == null
                          ? Icon(Icons.person, size: 60, color: Colors.blue)
                          : null,
                    ),
                  ),
                  // Ikon Edit Kecil (Hiasan)
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(Icons.edit, color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // --- NAMA & EMAIL ---
            Text(
              user?.displayName ?? "Nama Pengguna",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              user?.email ?? "email@kantor.com",
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),

            SizedBox(height: 30),

            // --- MENU OPSI (CARD) ---
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildProfileItem(
                    Icons.badge,
                    "NIP / ID Karyawan",
                    "123456789",
                    false,
                  ),
                  Divider(height: 1),
                  _buildProfileItem(
                    Icons.work,
                    "Jabatan",
                    "Senior Developer",
                    false,
                  ),
                  Divider(height: 1),
                  _buildProfileItem(
                    Icons.location_on,
                    "Lokasi Kantor",
                    "Dago, Bandung",
                    false,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // --- TOMBOL LOGOUT ---
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Konfirmasi Logout
                  bool confirm =
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Logout"),
                          content: Text("Yakin ingin keluar dari aplikasi?"),
                          actions: [
                            TextButton(
                              child: Text("Batal"),
                              onPressed: () => Navigator.pop(context, false),
                            ),
                            TextButton(
                              child: Text("Ya, Keluar"),
                              onPressed: () => Navigator.pop(context, true),
                            ),
                          ],
                        ),
                      ) ??
                      false;

                  if (confirm) {
                    await AuthService.logout();
                    Navigator.of(
                      context,
                    ).popUntil((route) => route.isFirst); // Tutup semua halaman
                  }
                },
                icon: Icon(Icons.logout),
                label: Text("Keluar Aplikasi"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50], // Merah pudar
                  foregroundColor: Colors.red, // Teks Merah
                  padding: EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),
            Text(
              "Versi Aplikasi 1.0.0",
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    IconData icon,
    String title,
    String value,
    bool isArrow,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[300], size: 24),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text(
                  value,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          if (isArrow)
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
