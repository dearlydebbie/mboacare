import 'package:flutter/material.dart';
import 'package:mboacare/register.dart';
import 'colors.dart';
import 'hospitaldashboard.dart';
import 'settings.dart';
import 'profile.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  final String userName;

  DashboardScreen({required this.userName, Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    DashboardContent(),
    HospitalDashbord(),
    SettingsPage(),
    ProfilePage(
      userName: 'Hi, Guest',
    ),
  ];

  final List<String> _screenTitles = [
    'Home',
    'Hospital Dashbord',
    'Settings',
    'Profile',
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screenTitles[_currentIndex]),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: AppColors.buttonColor,
        unselectedItemColor: AppColors.navbar,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Hospital Dashbord',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCard(),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Your Health, Simplified.',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Discover a world of medical facilities at your fingertips with Mboacare. Connect globally, collaborate effortlessly, and improve healthcare outcomes. Join now and revolutionize the way medical professionals connect and deliver care.',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20), // Add some space before the buttons
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the RegisterPage
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.cardbg,
                      onPrimary: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text('Hospital Sign Up'),
                  ),
                  SizedBox(height: 10), // Add some space between the buttons
                  ElevatedButton(
                    onPressed: () async {
                      // Open the LinkedIn URL in the browser
                      const url = 'https://www.linkedin.com/company/mboalab/';
                      final Uri uri = Uri.parse(url);
                      await launchUrl(uri);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text('Join the Community'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard() {
    return Container(
      width: 280,
      height: 230,
      margin: EdgeInsets.symmetric(horizontal: 14.0),
      constraints: BoxConstraints(
        maxWidth: 500,
        maxHeight: 900,
      ),
      child: Card(
        color: AppColors.cardbg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'lib/assests/images/doctor.png',
                  height: 300,
                  width: 150,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Join the network and make a global impact in Healthcare!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Inter',
                    ),
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
