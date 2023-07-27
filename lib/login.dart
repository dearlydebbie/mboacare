import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart';
import 'dashboard.dart';
import 'signUpPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required String title}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  Future<void> _signInWithEmail(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        _saveSignInStatus(
            user.email); // Save sign-in status to SharedPreferences
        // If the user is verified and successfully signed in, navigate to the dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Dashboard(userName: user.displayName ?? "")),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred during sign in: $error'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        _saveSignInStatus(
            user.email); // Save sign-in status to SharedPreferences
        // If the user is successfully signed in with Google, navigate to the dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Dashboard(userName: user.displayName ?? "")),
        );
      }
    } catch (error) {
      print(error);
    }
  }

  // Method to save sign-in status to SharedPreferences
  Future<void> _saveSignInStatus(String? email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSignedIn', true);
    prefs.setString(
        'email', email ?? ""); // If email is null, set an empty string
  }

  Future<void> _checkSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSignedIn = prefs.getBool('isSignedIn') ?? false;

    if (isSignedIn) {
      String? email = prefs.getString('email');
      // Navigate to the dashboard if the user is already signed in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(userName: email ?? ""),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 50.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assests/images/logo.png',
                width: 180,
              ),
              SizedBox(height: 12),
              Text(
                'Welcome to Mboacare',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 14),
              Text(
                'Your Health, Simplified!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.signInButtonColor,
                ),
              ),
              SizedBox(height: 80),
              Container(
                width: 320,
                height: 40,
                child: ElevatedButton(
                  onPressed: () => _signInWithEmail(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 320,
                height: 40,
                child: FloatingActionButton.extended(
                  onPressed: () => _signInWithGoogle(context),
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.googleButtonTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  icon: Image.asset(
                    'lib/assests/images/google-icon.png',
                    height: 32,
                    width: 32,
                  ),
                  label: Text('Sign in with Google'),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Text(
                  'Don\'t have an account? Sign up',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
