// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:Pulse/themes/components/header.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:Pulse/services/patient_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';

// //! Not tested for swap feature

// class QrCodePage extends StatefulWidget {
//   @override
//   _QrCodePageState createState() => _QrCodePageState();
// }

// class _QrCodePageState extends State<QrCodePage> {
//   String qrData = "";
//   bool isGenerating =
//       true; // Initially set to true for "รับเวร" to be highlighted
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(left: 16.0, right: 16, top: 16),
//             child: Header(size, true),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 16.0),
//             child: Row(children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(FontAwesomeIcons.backward),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.pop(context); // Same action as the IconButton
//                 },
//                 child: Text(
//                   S.of(context)!.back,
//                   style: GoogleFonts.inter(
//                     textStyle: TextStyle(
//                       fontSize: size.width * 0.05,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           SizedBox(height: size.height * 0.012),
//           Padding(
//             padding: EdgeInsets.only(left: 16),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 S.of(context)!.swapShift,
//                 style: GoogleFonts.inter(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.left,
//               ),
//             ),
//           ),
//           SizedBox(height: size.height * 0.02),
//           Expanded(
//             child: isGenerating ? _buildGenerator() : _buildReader(),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       isGenerating = true;
//                       qrData = ""; // Clear the QR data to reset the view
//                       controller?.pauseCamera();
//                     });
//                   },
//                   child: Text(
//                     S.of(context)!.sendShift,
//                     style: TextStyle(
//                       color: isGenerating ? Color(0xffBA90CB) : Colors.white,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(size.width * 0.39, size.width * 0.39),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     backgroundColor:
//                         isGenerating ? Colors.white : Color(0xffBA90CB),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       isGenerating = false;
//                       qrData = ""; // Clear the QR data to reset the view
//                       controller?.resumeCamera();
//                     });
//                   },
//                   child: Text(
//                     S.of(context)!.takeShift,
//                     style: TextStyle(
//                       color: isGenerating ? Colors.white : Color(0xffBA90CB),
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(size.width * 0.39, size.width * 0.39),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     backgroundColor:
//                         isGenerating ? Color(0xffBA90CB) : Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGenerator() {
//     return Center(
//       child: qrData.isEmpty
//           ? ElevatedButton(
//               onPressed: () {
//                 // Logic to generate QR code data
//                 setState(() {
//                   final uid = FirebaseAuth.instance.currentUser!.uid.toString();
//                   qrData = uid;
//                 });
//               },
//               child: Text(S.of(context)!.clickForQR),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(200.0, 200.0), // Square button
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             )
//           : QrImageView(
//               data: qrData,
//               size: 200.0,
//             ),
//     );
//   }

//   Widget _buildReader() {
//     List<Map<String, dynamic>> patients;
//     PatientService _patientService = PatientService();
//     final uid = FirebaseAuth.instance.currentUser!.uid.toString();
//     return Center(
//       child: qrData.isEmpty
//           ? QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//               overlay: QrScannerOverlayShape(
//                 borderColor: Colors.red,
//                 borderRadius: 10,
//                 borderLength: 30,
//                 borderWidth: 10,
//                 cutOutSize: 300,
//               ),
//             )
//           : StreamBuilder<List<Map<String, dynamic>>>(
//               stream: _patientService.getPinhandStream(qrData),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 }

//                 if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 }

//                 if (snapshot.hasData && snapshot.data != null) {
//                   patients = snapshot.data!;
//                   patients.forEach((patient) {
//                     _patientService.removeCareTaker(patient['id'], qrData);
//                     _patientService.setCareTaker(patient['id'], uid);
//                   });
//                   return Text(S.of(context)!.success);
//                 }
//                 return Text('No data found');
//               },
//             ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         qrData = scanData.code ?? '';
//       });
//       controller.pauseCamera();
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
