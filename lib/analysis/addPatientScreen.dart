// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/analysis/calculateMewsScreen.dart';
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
  // final _genderController = TextEditingController();
  final _hnController = TextEditingController();
  final _bedNumberController = TextEditingController();

  String? selectedValueWard;
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
                  Text(
                    S.of(context)!.back,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
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
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.fileSignature,
                              size: size.width * 0.2,
                            ),
                            SizedBox(width: size.width * 0.05),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(size.width * 0.03),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 250, 195, 219),
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.05),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context)!.addPatientDescription,
                                      style: TextStyle(
                                        fontSize: size.width * 0.06,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.045),
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
                          height: size.height * 0.055,
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
                                            S.of(context)!.male,
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
                        _buildFormRow(size, FontAwesomeIcons.solidHospital,
                            '${S.of(context)!.texthn}: ', _hnController),
                        SizedBox(height: size.height * 0.02),
                        _buildFormRow(
                            size,
                            FontAwesomeIcons.buildingUser,
                            '${S.of(context)!.textBedNum}: ',
                            _bedNumberController),
                        SizedBox(height: size.height * 0.02),
                        SizedBox(
                          width: size.width,
                          height: size.height * 0.055,
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
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'C', child: Text('C')),
                                      DropdownMenuItem(
                                          value: 'A', child: Text('A')),
                                      DropdownMenuItem(
                                          value: 'V', child: Text('V')),
                                      DropdownMenuItem(
                                          value: 'P', child: Text('P')),
                                      DropdownMenuItem(
                                          value: 'U', child: Text('U')),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValueWard = value;
                                      });
                                    },
                                    hint: Padding(
                                      padding: EdgeInsets.only(left: 18),
                                      child: Text(
                                        selectedValueWard ??
                                            S.of(context)!.textward,
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
                    FontAwesomeIcons.solidArrowAltCircleRight,
                    size: size.width * 0.07,
                    color: Colors.black,
                  ),
                  label: Text(
                    S.of(context)!.next,
                    style: TextStyle(
                        fontSize: size.width * 0.07, color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalculateMEWsScreen(
                          name: _nameController.text,
                          surname: _lastNameController.text,
                          gender: selectedValueGender ?? 'Male',
                          hn: int.tryParse(_hnController.text) ?? 0,
                          bedNum: int.tryParse(_bedNumberController.text) ?? 0,
                          ward: selectedValueWard ?? '',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormRow(Size size, IconData icon, String hintText,
      TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width *
              0.0764, // Set both width and height to the same value
          height: size.width * 0.07, // This ensures the icon is square
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
            decoration: InputDecoration(
              hintText: hintText,
              filled: true, // Enables the fillColor property
              fillColor: Colors.white, // Sets the background color to white
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.05),
                borderSide: BorderSide.none, // Removes the default border color
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
