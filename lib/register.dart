import 'package:flutter/material.dart';
import 'colors.dart';
import 'hospitaldashboard.dart'; // Import the HospitalDashboard screen file

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
                _buildFormItem(
                  label: 'Hospital Name *',
                  hintText: 'Enter hospital name',
                  onSaved: (value) => _hospitalName = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hospital name is required';
                    }
                    return null;
                  },
                ),
                _buildFormItem(
                  label: 'Hospital Address *',
                  hintText: 'Enter hospital address',
                  onSaved: (value) => _hospitalAddress = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hospital address is required';
                    }
                    return null;
                  },
                ),
                _buildFormItem(
                  label: 'Hospital Phone Number *',
                  hintText: 'Enter phone number',
                  onSaved: (value) => _hospitalPhone = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    return null;
                  },
                ),
                _buildFormItem(
                  label: 'Hospital Email Address *',
                  hintText: 'Enter email address',
                  onSaved: (value) => _hospitalEmail = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email address is required';
                    }
                    return null;
                  },
                ),
                _buildFormItem(
                  label: 'Hospital Website',
                  hintText: 'Enter website (optional)',
                  onSaved: (value) => _hospitalWebsite = value,
                ),
                SizedBox(height: 20),
                _buildChoiceChipForm(
                  title: 'Hospital Type *',
                  name: 'hospitalType',
                  options: ['Public', 'Private', 'Non-Profit'],
                  onChanged: (value) => _hospitalType = value,
                ),
                _buildChoiceChipForm(
                  title: 'Hospital Size *',
                  name: 'hospitalSize',
                  options: ['Small', 'Medium', 'Large'],
                  onChanged: (value) => _hospitalSize = value,
                ),
                SizedBox(height: 20),
                _buildChoiceChipForm(
                  title: 'Hospital Ownership',
                  name: 'hospitalOwnership',
                  options: ['Individual', 'Corporate', 'Government'],
                  onChanged: (value) => _hospitalOwnership = value,
                ),
                SizedBox(height: 20), // Add some space before the buttons
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Handle the form data as needed.
                      // You can access the form values using _hospitalName, _hospitalAddress, etc.

                      // Navigate to the HospitalDashboard screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HospitalDashbord(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white, // Set the text color to white
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors
                        .buttonColor, // Set the button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Set the button corner radius
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

  Widget _buildFormItem({
    required String label,
    required String hintText,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: hintText,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 4.0),
              ),
              onSaved: onSaved,
              validator: validator,
            ),
          ],
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
      case 'hospitalOwnership': // Add this case for the hospitalOwnership radio buttons
        return _hospitalOwnership;
      default:
        return null;
    }
  }
}
