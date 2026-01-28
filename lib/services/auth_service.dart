import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // 1. Fungsi Login Google
  static Future<User?> signInWithGoogle() async {
    try {
      // Trigger pop-up pilihan akun Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null; // User membatalkan login
      }

      // Ambil detail otentikasi (token) dari akun tersebut
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // PERBAIKAN DI SINI:
      // Kita hanya pakai idToken. accessToken dihapus supaya tidak error.
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        // accessToken: googleAuth.accessToken, <--- Baris ini dihapus/komentar
      );

      // Masuk ke Firebase pakai kredensial tadi
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print("Error Login: $e");
      return null;
    }
  }

  // 2. Fungsi Logout
  static Future<void> logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
