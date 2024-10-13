import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Pulse/analysis/calculateMewsAndUpdateScreen.dart';
import 'package:Pulse/patientinfo/patientListPage.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/services/patient_service.dart';

class UpdatePatientScreen extends StatefulWidget {
  final String patientID;
  final bool renderNextButton;

  UpdatePatientScreen(
      {super.key, required this.patientID, required this.renderNextButton});

  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<UpdatePatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _hnController = TextEditingController();
  final _bedNumberController = TextEditingController();

  Map<String, dynamic> _patientDetails = {
    'Name': '',
    'Last Name': '',
    'gender': '',
    'bed_number': '',
    'hospital_number': '',
    'ward_number': '',
    'inspection_time': ''
  };

  String? selectedValueWard;
  String? selectedValueGender;

  @override
  void initState() {
    super.initState();
    _fetchPatientDetails();
  }

  Future<void> _fetchPatientDetails() async {
    try {
      final patientDetails =
          await PatientService().getPatientById(widget.patientID);
      setState(() {
        _patientDetails = {
          'Name': patientDetails['name'] ?? '',
          'Last Name': patientDetails['lastname'] ?? '',
          'gender': patientDetails['gender'] ?? '',
          'bed_number': patientDetails['bed_number'] ?? '',
          'hospital_number': patientDetails['hospital_number'] ?? '',
          'ward_number': patientDetails['ward_number'] ?? '',
          'inspection_time': patientDetails['inspection_time'] ?? '',
        };

        _nameController.text = _patientDetails['Name']!;
        _lastNameController.text = _patientDetails['Last Name']!;
        selectedValueGender = _patientDetails['gender'];
        _bedNumberController.text = _patientDetails['bed_number']!;
        _hnController.text = _patientDetails['hospital_number']!;
        selectedValueWard = _patientDetails['ward_number'];
      });
    } catch (e) {
      print('Failed to fetch patient details: $e');
    }
  }

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
              Text(
                S.of(context)!.updatePatient,
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
              SizedBox(height: size.width * 0.05),
              Center(
                child: widget.renderNextButton
                    ? TextButton.icon(
                        icon: FaIcon(
                          FontAwesomeIcons.solidCircleRight,
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
                              builder: (context) =>
                                  CalculateMEWsAndUpdateScreen(
                                name: _nameController.text.isNotEmpty
                                    ? _nameController.text
                                    : _patientDetails['Name']!,
                                surname: _lastNameController.text.isNotEmpty
                                    ? _lastNameController.text
                                    : _patientDetails['Last Name']!,
                                gender: selectedValueGender ??
                                    _patientDetails['gender']!,
                                hn: int.tryParse(_hnController.text) ??
                                    int.tryParse(
                                        _patientDetails['hospital_number']!)!,
                                bedNum:
                                    int.tryParse(_bedNumberController.text) ??
                                        int.tryParse(
                                            _patientDetails['bed_number']!)!,
                                ward: selectedValueWard ??
                                    _patientDetails['ward_number']!,
                                patientID: widget.patientID,
                              ),
                            ),
                          );
                        },
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(size.width * 0.4, size.height * 0.085),
                            backgroundColor: Color(0xffBA90CB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        child: Text(
                          S.of(context)!.save,
                          style: TextStyle(
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            PatientService().updatePatientData(
                                patientID: widget.patientID,
                                name: _nameController.text,
                                lastname: _lastNameController.text,
                                gender: selectedValueGender ??
                                    _patientDetails['gender'],
                                bed_number: _bedNumberController.text,
                                hospital_number: _hnController.text,
                                ward_number: selectedValueWard!,
                                inspection_time:
                                    _patientDetails['inspection_time']
                                        .toDate());
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Patientlistpage()),
                            );
                          }
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
          width: size.width * 0.0764,
          height: size.width * 0.07,
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
        ),
      ],
    );
  }
}
