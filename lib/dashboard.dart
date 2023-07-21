import 'package:flutter/material.dart';
import 'hospital.dart';
import 'hospitaldetails.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _searchQuery = "";
  String _selectedFilter = "View All";

  @override
  Widget build(BuildContext context) {
    List<Hospital> filteredHospitals = hospitals
        .where((hospital) =>
            _selectedFilter == "View All" ||
            hospital.specialty == _selectedFilter)
        .where((hospital) =>
            _searchQuery.isEmpty ||
            hospital.keywords.any((keyword) => keyword.contains(_searchQuery)))
        .toList();

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
                    return GestureDetector(
                      onTap: () {
                        _navigateToDetailsPage(hospital);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.all(16.0),
                        height: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.grey,
                          image: DecorationImage(
                            image: AssetImage(hospital.image),
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hospital.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              hospital.specialty,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    _buildFeatureBox("General Medicine"),
                                    SizedBox(width: 8),
                                    _buildFeatureBox("Cardiology"),
                                  ],
                                ),
                                Icon(Icons.arrow_forward, color: Colors.white),
                              ],
                            ),
                          ],
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
