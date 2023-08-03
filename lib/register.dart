import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart';
import 'hospital_provider.dart';
import 'hospital_model.dart';
import 'hospitaldashboard.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _hospitalName;
  String? _hospitalAddress;
  String? _hospitalPhone;
  String? _hospitalEmail;
  String? _hospitalWebsite;
  String? _hospitalType;
  String? _hospitalSize;
  String? _hospitalOwnership;
  String? _hospitalSpecialities;

  ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _selectedImage = File(pickedImage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Hospital Name
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hospital Name *',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter hospital name',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            isDense: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 4.0),
                          ),
                          onSaved: (value) => _hospitalName = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Hospital name is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Hospital Address
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hospital Address *',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter hospital address',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            isDense: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 4.0),
                          ),
                          onSaved: (value) => _hospitalAddress = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Hospital address is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Hospital Phone Number
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hospital Phone Number *',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter phone number',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            isDense: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 4.0),
                          ),
                          onSaved: (value) => _hospitalPhone = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone number is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Hospital Email Address
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hospital Email Address',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter email address (optional)',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            isDense: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 4.0),
                          ),
                          onSaved: (value) => _hospitalEmail = value,
                        ),
                      ],
                    ),
                  ),
                ),

                // Hospital Website
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hospital Website',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter website (optional)',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            isDense: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 4.0),
                          ),
                          onSaved: (value) => _hospitalWebsite = value,
                        ),
                      ],
                    ),
                  ),
                ),

                // Specialities for the Hospitals
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Specialities for the Hospitals',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter hospital specialities',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            isDense: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 4.0),
                          ),
                          onSaved: (value) => _hospitalSpecialities = value,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Radio buttons for Hospital Type
                _buildChoiceChipForm(
                  title: 'Hospital Type *',
                  name: 'hospitalType',
                  options: ['Public', 'Private', 'Non-Profit'],
                  onChanged: (value) => _hospitalType = value,
                ),

                // Radio buttons for Hospital Size
                _buildChoiceChipForm(
                  title: 'Hospital Size *',
                  name: 'hospitalSize',
                  options: ['Small', 'Medium', 'Large'],
                  onChanged: (value) => _hospitalSize = value,
                ),

                // Radio buttons for Hospital Ownership
                _buildChoiceChipForm(
                  title: 'Hospital Ownership',
                  name: 'hospitalOwnership',
                  options: ['Individual', 'Corporate', 'Government'],
                  onChanged: (value) => _hospitalOwnership = value,
                ),

                SizedBox(height: 20),

                TextButton(
                  onPressed: _pickImage,
                  child: Text(
                    'Select Image (Optional)',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),

                if (_selectedImage != null)
                  Image.file(
                    _selectedImage!,
                    height: 150,
                  ),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Handle the form data as needed.

                      // Add hospital data to the HospitalProvider
                      final hospitalProvider =
                          Provider.of<HospitalProvider>(context, listen: false);
                      hospitalProvider.addHospital(HospitalData(
                        hospitalName: _hospitalName!,
                        hospitalAddress: _hospitalAddress!,
                        hospitalSpecialities: _hospitalSpecialities!,
                        hospitalImage: _selectedImage,
                      ));

                      // Navigate to the HospitalDashboard screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HospitalDashboard(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceChipForm({
    required String title,
    required String name,
    required List<String> options,
    void Function(String)? onChanged,
  }) {
    String? selectedOption = _getSelectedOption(name);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...options.map(
              (option) => Row(
                children: [
                  Radio<String>(
                    value: option,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                        if (onChanged != null) {
                          onChanged(value!);
                        }
                      });
                    },
                  ),
                  SizedBox(width: 8),
                  Text(option),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _getSelectedOption(String name) {
    switch (name) {
      case 'hospitalType':
        return _hospitalType;
      case 'hospitalSize':
        return _hospitalSize;
      case 'hospitalOwnership':
        return _hospitalOwnership;
      default:
        return null;
    }
  }

  Future<void> _saveHospitalDataToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> hospitalDataList = [
      _hospitalName ?? "",
      _hospitalAddress ?? "",
      _hospitalPhone ?? "",
      _hospitalEmail ?? "",
      _hospitalWebsite ?? "",
      _hospitalType ?? "",
      _hospitalSize ?? "",
      _hospitalOwnership ?? "",
      _hospitalSpecialities ?? "",
      _selectedImage?.path ?? "",
    ];

    prefs.setStringList('hospitalData', hospitalDataList);
  }
}
