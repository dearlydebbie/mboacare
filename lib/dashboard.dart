import 'package:flutter/material.dart';
import 'hospital.dart';
import 'hospitaldetails.dart';
import 'colors.dart';
import 'profile.dart';
import 'settings.dart';

class Dashboard extends StatefulWidget {
  final String? userName;

  Dashboard({this.userName});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _searchQuery = "";
  String _selectedFilter = "View All";
  List<Hospital> filteredHospitals = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    filteredHospitals = hospitals;
  }

  void _filterHospitals() {
    setState(() {
      filteredHospitals = hospitals
          .where((hospital) =>
              _selectedFilter == "View All" ||
              hospital.specialty == _selectedFilter)
          .where((hospital) =>
              _searchQuery.isEmpty ||
              hospital.name
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              hospital.keywords.any(
                (keyword) => keyword.contains(_searchQuery.toLowerCase()),
              ))
          .toList();
    });
  }

  Widget _buildFilterText(String filter) => GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = filter;
            _filterHospitals();
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            filter,
            style: TextStyle(
              color: _selectedFilter == filter ? Colors.green : Colors.black,
              fontWeight: _selectedFilter == filter
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      );

  Widget _buildFeatureBox(String text, Color color) => Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.buttonColor),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.buttonColor,
          ),
        ),
      );

  Widget _buildArrowButton(Hospital hospital) => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _navigateToDetailsPage(hospital),
          splashColor: Colors.green.withOpacity(0.5),
          highlightColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.buttonColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      );

  void _navigateToDetailsPage(Hospital hospital) {
    // ignore: unnecessary_null_comparison
    if (hospital != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HospitalDetailsPage(hospital: hospital),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Selected hospital is null!")),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    DashboardScreen(),
    HospitalDetailsPage(
        hospital:
            null), // Replace null with an actual Hospital object when navigating
    SettingsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Dashboard'),
      ),
      body: Container(
        constraints: BoxConstraints(maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.search, color: Colors.green),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                          _filterHospitals();
                        },
                        decoration: InputDecoration(
                          hintText: "Search hospitals...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFilterText("View All"),
                  _buildFilterText("General Medicine"),
                  _buildFilterText("Surgery"),
                  _buildFilterText("Cardiology"),
                  _buildFilterText("Brain"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hi, ${widget.userName ?? 'Guest'}!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton<String>(
                  value: _selectedFilter,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFilter = newValue!;
                      _filterHospitals();
                    });
                  },
                  dropdownColor: Colors.white,
                  items: <String>[
                    "View All",
                    "General Medicine",
                    "Surgery",
                    "Cardiology",
                    "Brain",
                  ].map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child:
                            Text(value, style: TextStyle(color: Colors.green)),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            Expanded(
              child: _screens[_selectedIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(236, 253, 237, 1),
        selectedItemColor: Color.fromRGBO(16, 101, 23, 1),
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Hospital',
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

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
