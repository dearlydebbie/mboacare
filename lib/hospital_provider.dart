import 'package:flutter/foundation.dart';
import 'hospital_model.dart';

class HospitalProvider with ChangeNotifier {
  List<HospitalData> _hospitals = [];

  List<HospitalData> get hospitals => _hospitals;

  List<HospitalData> _filteredHospitals = [];

  List<HospitalData> get filteredHospitals => _filteredHospitals;

  // Constructor to initialize the HospitalProvider with data
  HospitalProvider(List<HospitalData> initialData) {
    _hospitals = initialData;
    _filteredHospitals =
        _hospitals; // Initially, set filteredHospitals to all hospitals
  }

  void filterHospitals(String query) {
    _filteredHospitals = _hospitals.where((hospital) {
      return hospital.hospitalName
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          hospital.hospitalSpecialities
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();

    notifyListeners();
  }

  void addHospital(HospitalData hospital) {
    _hospitals.add(hospital);
    notifyListeners();
  }
}
