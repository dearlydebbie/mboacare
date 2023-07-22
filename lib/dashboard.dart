import 'package:flutter/material.dart';
import 'hospital.dart';
import 'hospitaldetails.dart';
import 'colors.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _searchQuery = "";
  String _selectedFilter = "View All";

  // Function to filter hospitals based on their names
  List<Hospital> _searchHospitalsByName(String query) {
    return hospitals
        .where((hospital) =>
            _selectedFilter == "View All" ||
            hospital.specialty == _selectedFilter)
        .where((hospital) =>
            query.isEmpty ||
            hospital.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // Filter the hospitals based on search query
    List<Hospital> filteredHospitals = _searchHospitalsByName(_searchQuery);

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
                child: DropdownButton<String>(
                  value: _selectedFilter,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFilter = newValue!;
                    });
                  },
                  dropdownColor: Colors.white,
                  items: <String>[
                    "View All",
                    "General Medicine",
                    "Surgery",
                    "Cardiology",
                    "Brain",
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.green)),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  itemCount: filteredHospitals.length,
                  itemBuilder: (context, index) {
                    Hospital hospital = filteredHospitals[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          _navigateToDetailsPage(hospital);
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Hospital Name with more spacing below the image
                                    SizedBox(height: 12),
                                    Text(
                                      hospital.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    // Specialty
                                    Text(
                                      hospital.specialty,
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    // Feature Boxes
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            _buildFeatureBox(
                                                "General Medicine"),
                                            SizedBox(width: 8),
                                            _buildFeatureBox("Cardiology"),
                                          ],
                                        ),
                                        Icon(Icons.arrow_forward,
                                            color: Colors.white),
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
      ),
    );
  }

  Widget _buildFilterText(String filter) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filter;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          filter,
          style: TextStyle(
            color: _selectedFilter == filter ? Colors.green : Colors.black,
            fontWeight:
                _selectedFilter == filter ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureBox(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.lightGreen),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.lightGreen,
        ),
      ),
    );
  }

  void _navigateToDetailsPage(Hospital hospital) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HospitalDetailsPage(hospital: hospital),
      ),
    );
  }
}
