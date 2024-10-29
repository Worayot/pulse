// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, prefer_const_constructors

import 'package:Pulse/functions/addPatient.dart';
import 'package:Pulse/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _hnController = TextEditingController();
  final _bedNumberController = TextEditingController();
  final _wardController = TextEditingController();

  String? selectedValueGender;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Map<String, String> genderMap = {
      'Male': S.of(context)!.male,
      'Female': S.of(context)!.female,
    };
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(size, true),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(FontAwesomeIcons.backward),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      S.of(context)!.back,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                S.of(context)!.buttonaddPatients,
                style: TextStyle(
                  fontSize: size.width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  color: const Color(0xffFFDDEC),
                  borderRadius: BorderRadius.circular(size.width * 0.04),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   children: [
                        //     FaIcon(
                        //       FontAwesomeIcons.fileSignature,
                        //       size: size.width * 0.2,
                        //     ),
                        //     SizedBox(width: size.width * 0.05),
                        //     Expanded(
                        //       child: Container(
                        //         padding: EdgeInsets.all(size.width * 0.03),
                        //         decoration: BoxDecoration(
                        //           color: Color.fromARGB(255, 250, 195, 219),
                        //           borderRadius:
                        //               BorderRadius.circular(size.width * 0.05),
                        //         ),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               S.of(context)!.addPatientDescription,
                        //               style: TextStyle(
                        //                 fontSize: size.width * 0.06,
                        //                 fontWeight: FontWeight.bold,
                        //                 color: Colors.black,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: size.height * 0.01),
                        _buildFormRow(size, FontAwesomeIcons.userAlt,
                            '${S.of(context)!.textname}: ', _nameController),
                        SizedBox(height: size.height * 0.02),
                        _buildFormRow(
                            size,
                            FontAwesomeIcons.userAlt,
                            '${S.of(context)!.textsurname}: ',
                            _lastNameController),
                        SizedBox(height: size.height * 0.02),
                        SizedBox(
                          width: size.width,
                          // height: size.height * 0.055,
                          height: 37,
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.userAlt,
                                  size: size.width * 0.074,
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                              SizedBox(width: size.width * 0.05),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.05),
                                  ),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    items: genderMap.keys.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(genderMap[value]!),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValueGender = value;
                                      });
                                    },
                                    hint: Padding(
                                      padding: EdgeInsets.only(left: 18),
                                      child: Text(
                                        genderMap[selectedValueGender] ??
                                            S.of(context)!.textgender,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: size.width * 0.04),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        _buildFormRow(
                          size,
                          FontAwesomeIcons.solidHospital,
                          '${S.of(context)!.texthn}: ',
                          _hnController,
                          inputType: TextInputType.number,
                        ),
                        SizedBox(height: size.height * 0.02),
                        _buildFormRow(
                          size,
                          FontAwesomeIcons.buildingUser,
                          '${S.of(context)!.textBedNum}: ',
                          _bedNumberController,
                          inputType: TextInputType.number,
                        ),
                        SizedBox(height: size.height * 0.02),
                        _buildFormRow(size, FontAwesomeIcons.userAlt,
                            '${S.of(context)!.textward}: ', _wardController),
                        SizedBox(height: size.height * 0.01),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.width * 0.02),
              Center(
                child: TextButton.icon(
                  icon: FaIcon(
                    FontAwesomeIcons.fileUpload,
                    size: size.width * 0.07,
                    color: Colors.black,
                  ),
                  label: Text(
                    S.of(context)!.save,
                    style: TextStyle(
                        fontSize: size.width * 0.07, color: Colors.black),
                  ),
                  onPressed: () {
                    // Extracting the form data
                    String name = _nameController.text.trim();
                    String surname = _lastNameController.text.trim();
                    String hn = _hnController.text.trim();
                    String bedNum = _bedNumberController.text.trim();
                    String? gender =
                        selectedValueGender; // Get selected gender directly
                    String ward = _wardController.text.trim();

                    // Validate if the required fields are filled
                    if (name.isEmpty ||
                        surname.isEmpty ||
                        hn.isEmpty ||
                        bedNum.isEmpty ||
                        gender == null ||
                        ward.isEmpty) {
                      // Show a message if any required field is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(S.of(context)!.fillAllFields)),
                      );
                      return; // Exit early if validation fails
                    }

                    // Call the addPatient function with the collected form data
                    addPatient(context, name, surname, gender, hn, bedNum, ward)
                        .then((success) {
                      // Navigate to the HomeScreen only if the addPatient function is successful
                      if (success) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      } else {
                        // Optionally show an error message if the save failed
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(S.of(context)!.saveFailed)),
                        );
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormRow(Size size, IconData icon, String hintText,
      TextEditingController controller,
      {TextInputType? inputType}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width *
              0.0764, // Set both width and height to the same value
          // height: size.width * 0.07, // This ensures the icon is square
          height: 40,
          child: FaIcon(
            icon,
            size: size.width * 0.07,
            color: Colors.black,
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: inputType,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.05),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: size.height * 0.007,
                horizontal: size.width * 0.04,
              ),
              isDense: true,
            ),
            style: TextStyle(fontSize: size.width * 0.042),
          ),
        )
      ],
    );
  }
}
