import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'hospital_provider.dart';
import 'colors.dart';

class HospitalDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hospitalProvider = Provider.of<HospitalProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                for (var hospital in hospitalProvider.hospitals)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    padding: const EdgeInsets.all(16.0),
                    height: 300,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Hospital Image
                          Container(
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                              ),
                              image: hospital.hospitalImage != null
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(hospital.hospitalImage!),
                                    )
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'lib/assests/images/placeholder_image.png'),
                                    ),
                            ),
                          ),

                          SizedBox(height: 8),

                          // Display Hospital Name with Right Arrow Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  hospital.hospitalName.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor2,
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.buttonColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 2),

                          // Display Hospital Address
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              hospital.hospitalAddress,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textColor2,
                              ),
                            ),
                          ),

                          SizedBox(height: 6),

                          // Display Hospital Specialities as Colorful Boxes
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: hospital.hospitalSpecialities
                                  .split(',')
                                  .map(
                                    (speciality) => Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 4.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.01),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.green,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Text(
                                        speciality.trim(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),

                          // ... Add any other hospital information here ...
                        ],
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
}
