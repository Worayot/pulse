// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pulse/themes/components/header.dart';

// class BarcodeScanner extends StatefulWidget {
//   @override
//   _BarcodeScannerState createState() => _BarcodeScannerState();
// }

// class _BarcodeScannerState extends State<BarcodeScanner> {
//   String _scanResult = 'Unknown';

//   Future<void> startBarcodeScan() async {
//     String barcodeScanRes;
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666', // Color for the cancel button
//         'Cancel', // Cancel button text
//         true, // Show flash icon
//         ScanMode.BARCODE, // Scan mode (can also be QR code)
//       );
//       print('Scan result: $barcodeScanRes');
//     } catch (e) {
//       barcodeScanRes = 'Failed to get scan result.';
//       // print(e);
//     }

//     // Update the UI with the scan result
//     if (!mounted) return;

//     setState(() {
//       _scanResult = barcodeScanRes;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     // return Scaffold(
//     //   body: Center(
//     //     child: Column(
//     //       mainAxisAlignment: MainAxisAlignment.center,
//     //       children: [
//     //         Text('Scan result: $_scanResult'),
//     //         SizedBox(height: 20),
//     //         ElevatedButton(
//     //           onPressed: startBarcodeScan,
//     //           child: Text('Start Barcode Scan'),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // );

//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Header(size, true),
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(FontAwesomeIcons.backward),
//                 ),
//                 Text(
//                   S.of(context)!.back,
//                   style: GoogleFonts.inter(
//                     textStyle: TextStyle(
//                       fontSize: size.width * 0.05,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Scan result: $_scanResult'),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: startBarcodeScan,
//                   child: Text('Start Barcode Scan'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // void main() => runApp(MaterialApp(home: BarcodeScanner()));
