import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGitHub() async {
    // Replace this with your actual GitHub OAuth token logic
    final githubProvider = GithubAuthProvider();

    try {
      final UserCredential userCredential = await _auth.signInWithProvider(githubProvider);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: $e');
      return null;
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  String? getProfilePhotoUrl(User? user) {
    return user?.photoURL;
  }
}
