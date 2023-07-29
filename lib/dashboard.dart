import 'package:flutter/material.dart';
import 'hospital.dart';
import 'hospitaldetails.dart';
import 'settings.dart';
import 'profile.dart';
import 'colors.dart';

class Dashboard extends StatefulWidget {
  final String userName;

  Dashboard({required this.userName, Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _searchQuery = "";
  String _selectedFilter = "View All";
  String _selectedDropDownFilter = "View All";
  Hospital? _selectedHospital; // New variable to store the selected hospital

  List<Hospital> get filteredHospitals => hospitals
      .where((hospital) =>
          (_selectedFilter == "View All" ||
              hospital.specialty == _selectedFilter) &&
          (_selectedDropDownFilter == "View All" ||
              hospital.specialty == _selectedDropDownFilter))
      .where((hospital) =>
          _searchQuery.isEmpty ||
          hospital.name.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  List<String> _dropDownFilterOptions = [
    "View All",
    "General Medicine",
    "Surgery",
    "Cardiology",
    "Brain",
  ];

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildBody() {
    if (_currentIndex == 0) {
      return DashboardScreen(
        selectedFilter: _selectedFilter,
        onFilterSelected: _onFilterSelected,
        dropDownFilterOptions: _dropDownFilterOptions,
        selectedDropDownFilter: _selectedDropDownFilter,
        filteredHospitals: filteredHospitals,
        navigateToDetailsPage: _navigateToDetailsPage,
      );
    } else if (_currentIndex == 1 && _selectedHospital != null) {
      return HospitalDetailsPage(hospital: _selectedHospital!);
    } else if (_currentIndex == 2) {
      return SettingsPage();
    } else if (_currentIndex == 3) {
      return ProfilePage(
          userName: widget.userName); // Passing the userName to the ProfilePage
    }

    return Container();
  }

  void _onFilterSelected(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Dashboard'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Hi, ${widget.userName}!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: Color(0xFFECFDED), // Set the navigation bar color
        selectedItemColor: AppColors.buttonColor, // Set the selected icon color
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Hospital Details',
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

  void _navigateToDetailsPage(BuildContext context, Hospital hospital) {
    setState(() {
      _selectedHospital = hospital; // Update the selected hospital
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HospitalDetailsPage(hospital: hospital),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;
  final List<String> dropDownFilterOptions;
  final String selectedDropDownFilter;
  final List<Hospital> filteredHospitals;
  final Function(BuildContext, Hospital) navigateToDetailsPage;

  DashboardScreen({
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.dropDownFilterOptions,
    required this.selectedDropDownFilter,
    required this.filteredHospitals,
    required this.navigateToDetailsPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        // Implement search logic here
                        // You can set _searchQuery and call setState to rebuild the filtered list
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
            padding: const EdgeInsets.all(8.0),
            child: _buildDropDownFilter(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: filteredHospitals.length,
                itemBuilder: (context, index) {
                  Hospital hospital = filteredHospitals[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        navigateToDetailsPage(context, hospital);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Hospital Image
                            Container(
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  topRight: Radius.circular(16.0),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(hospital.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            // Hospital Name with arrow button
                            Container(
                              height: 30,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        hospital.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  _buildArrowButton(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Specialty
                                  Text(
                                    hospital.specialty,
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  // Feature Boxes
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          _buildFeatureBox(
                                            "General Medicine",
                                            Colors.blue.withOpacity(0.01),
                                          ),
                                          SizedBox(width: 8),
                                          _buildFeatureBox(
                                            "Cardiology",
                                            Colors.red.withOpacity(0.01),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterText(String filter) => GestureDetector(
        onTap: () {
          onFilterSelected(filter);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            filter,
            style: TextStyle(
              color: selectedFilter == filter
                  ? AppColors.primaryColor
                  : Colors.black,
              fontWeight: selectedFilter == filter
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      );

  Widget _buildDropDownFilter() => DropdownButton(
        value: selectedDropDownFilter,
        onChanged: (value) {
          onDropDownFilterSelected(value.toString());
        },
        items: dropDownFilterOptions.map((String option) {
          return DropdownMenuItem(
            value: option,
            child: Text(
              option,
              style: TextStyle(color: Colors.green),
            ),
          );
        }).toList(),
      );

  Widget _buildFeatureBox(String text, Color color) => Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.primaryColor,
          ),
        ),
      );

  Widget _buildArrowButton() => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            // Handle arrow button tap here
          },
          splashColor: Colors.green.withOpacity(0.5),
          highlightColor: Colors.transparent,
          child: Container(
            height: 45,
            width: 40,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

  void onDropDownFilterSelected(String filter) {
    onFilterSelected(filter);
  }
}
