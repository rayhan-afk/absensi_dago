import 'package:flutter/material.dart';
import 'package:absensi_dago/services/auth_service.dart';

class AttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Absensi"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService.logout();
            },
          ),
        ],
      ),
      body: Center(child: Text("Halaman Absensi (Isi codingan di sini nanti)")),
    );
  }
}
