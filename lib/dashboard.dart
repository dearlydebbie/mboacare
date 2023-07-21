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
                  _buildFilterText("Heart"),
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
                    "Heart",
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
                  padding: const EdgeInsets.all(16.0),
                  child: _buildHospitalList(filteredHospitals)),
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

  Widget _buildHospitalList(List<Hospital> hospitals) {
    return ListView.builder(
      itemCount: hospitals.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset(
            hospitals[index].image,
            width: 80,
            height: 80,
          ),
          title: Text(hospitals[index].name),
          subtitle: Text(hospitals[index].specialty),
          onTap: () {
            _navigateToDetailsPage(hospitals[index]);
          },
        );
      },
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
