import 'dart:io';

class HospitalData {
  final String hospitalName;
  final String hospitalAddress;
  final String hospitalSpecialities;
  final File? hospitalImage;

  HospitalData({
    required this.hospitalName,
    required this.hospitalAddress,
    required this.hospitalSpecialities,
    this.hospitalImage,
  });
}
