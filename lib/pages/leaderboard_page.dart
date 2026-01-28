import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mengambil warna tema dari main.dart
    final primaryColor = Theme.of(context).primaryColor; // Royal Blue
    final goldColor = Color(0xFFF6AE31); // Warna Emas (dari HTML tadi)

    return Scaffold(
      // Background atas Biru (Profesional)
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Column(
            children: [
              // --- HEADER & PODIUM SECTION ---
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      // Header Navigasi
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            child: Text(
                              "Juara Minggu Ini 🏆",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 48), // Spacer biar title di tengah
                        ],
                      ),

                      SizedBox(height: 20),

                      // PODIUM (Top 3)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                            CrossAxisAlignment.end, // Biar kaki sejajar
                        children: [
                          // JUARA 2 (Kiri)
                          _buildPodiumItem(
                            context,
                            name: "Reza",
                            score: "980",
                            rank: 2,
                            avatarColor: Colors.lightBlue[200]!,
                            height: 140, // Tinggi tiang
                          ),

                          // JUARA 1 (Tengah - Lebih Besar)
                          _buildPodiumItem(
                            context,
                            name: "Giras",
                            score: "1250",
                            rank: 1,
                            avatarColor: goldColor,
                            height: 170, // Lebih tinggi
                            isWinner: true, // Ada mahkota
                          ),

                          // JUARA 3 (Kanan)
                          _buildPodiumItem(
                            context,
                            name: "Ridwan",
                            score: "945",
                            rank: 3,
                            avatarColor: Colors.brown[300]!,
                            height: 120, // Lebih pendek
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // --- LIST RUNNERS UP (Background Putih Melengkung) ---
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(
                      20,
                      20,
                      20,
                      100,
                    ), // Padding bawah besar biar gak ketutup floating card
                    itemCount: 10, // Contoh data dummy
                    itemBuilder: (context, index) {
                      int rank = index + 4; // Mulai dari ranking 4
                      return _buildListItem(context, rank);
                    },
                  ),
                ),
              ),
            ],
          ),

          // --- FLOATING CARD (User Sendiri) ---
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Color(
                  0xFF1E3A8A,
                ), // Biru Gelap (Stitch Dark) agar kontras
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.white24, width: 1),
              ),
              child: Row(
                children: [
                  // Rank Kita
                  Container(
                    width: 30,
                    child: Text(
                      "42",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: goldColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),

                  // Avatar Kita
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 12),

                  // Teks
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Anda (You)",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Keep going!",
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                        ),
                      ],
                    ),
                  ),

                  // Poin Kita
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "340",
                          style: TextStyle(
                            color: goldColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.star, size: 14, color: goldColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET: Item Podium (Tiang Juara)
  Widget _buildPodiumItem(
    BuildContext context, {
    required String name,
    required String score,
    required int rank,
    required Color avatarColor,
    required double height,
    bool isWinner = false,
  }) {
    return Container(
      width: 90, // Lebar tiang
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Avatar & Badge
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Mahkota (Khusus Juara 1)
              if (isWinner)
                Positioned(
                  top: -24,
                  child: Text("👑", style: TextStyle(fontSize: 24)),
                ),

              // Lingkaran Foto
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [avatarColor, avatarColor.withOpacity(0.6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    if (isWinner)
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.5),
                        blurRadius: 15,
                      ),
                  ],
                ),
                child: CircleAvatar(
                  radius: isWinner ? 35 : 28, // Juara 1 lebih besar
                  backgroundColor: Colors.white,
                  child: Text(
                    name[0],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),

              // Badge Angka (1, 2, 3)
              Positioned(
                bottom: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: rank == 1
                        ? Color(0xFFF6AE31)
                        : (rank == 2 ? Colors.grey[300] : Colors.brown[300]),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Text(
                    "$rank",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Nama User
          Text(
            name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),

          // Poin
          Container(
            margin: EdgeInsets.only(top: 4),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "$score pts",
              style: TextStyle(
                color: Color(0xFFF6AE31),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET: List Item (Rank 4 ke bawah)
  Widget _buildListItem(BuildContext context, int rank) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50), // Rounded pill shape
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Nomor Ranking
          Container(
            width: 30,
            child: Text(
              "$rank",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),

          // Avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue[50],
            child: Icon(Icons.person, size: 18, color: Colors.blue),
          ),
          SizedBox(width: 12),

          // Nama
          Expanded(
            child: Text(
              "Karyawan $rank",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          // Poin
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${1000 - (rank * 10)}", // Dummy point logic
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
