// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/functions/getLocoalizedString.dart';
import 'package:Pulse/patientinfo/indPatientData.dart';
import 'package:Pulse/models/headerRow.dart';
import 'package:Pulse/themes/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/services/mews_service.dart';

// In state of development
class FullReport extends StatefulWidget {
  final String patientID;
  const FullReport({super.key, required this.patientID});

  @override
  State<FullReport> createState() => _FullReportState();
}

class _FullReportState extends State<FullReport> {
  int currentPage = 1;
  int length = 15;
  double totalRow = 0;

  TableRow buildTableHeadRow(int numberOfCells) {
    // List to hold TableCell widgets
    List<TableCell> cells = [];

    // Create TableCell widgets in a loop
    for (int i = 0; i < numberOfCells; i++) {
      TableCell cell = TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(headerName[i]),
        ),
      );
      cells.add(cell);
    }

    return TableRow(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 215, 229, 202),
      ),
      children: cells,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<List<Map<String, dynamic>>>(
            stream: MewsService().getMewsStream(widget.patientID),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: Text('No data available for this patient'));
              }

              final mewsList = snapshot.data!;
              totalRow =
                  mewsList.length.toDouble(); // Update total rows dynamically

              List<String> pageNumList = List<String>.generate(
                (totalRow ~/ length) + 1,
                (index) => (index + 1).toString(),
              );

              String maxNumber = pageNumList.reduce(
                (currentMax, next) =>
                    int.parse(currentMax) > int.parse(next) ? currentMax : next,
              );

              return Column(children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 950,
                    child: Table(
                      border: const TableBorder.symmetric(
                          inside: BorderSide(),
                          outside: BorderSide(),
                          borderRadius: BorderRadius.zero),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        buildTableHeadRow(9),
                        ...List.generate(
                          currentPage != int.parse(maxNumber)
                              ? length
                              : totalRow.toInt() -
                                  ((int.parse(maxNumber) - 1) * length),
                          (index) {
                            final mewsData =
                                mewsList[(currentPage - 1) * length + index];
                            mewsData['consciousness'] =
                                getLocalizedConsciousValue(
                                    context, mewsData['consciousness']);
                            return TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(mewsData['timestamp'] != null
                                        ? mewsData['timestamp']
                                                .toDate()
                                                .toString()
                                                .split(' ')[0] +
                                            '\n' +
                                            mewsData['timestamp']
                                                .toDate()
                                                .toString()
                                                .split(' ')[1]
                                                .split('.')[0]
                                        : 'N/A'),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                        mewsData['consciousness']?.toString() ??
                                            'N/A'),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                        mewsData['temperature']?.toString() ??
                                            'N/A'),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                        mewsData['heart_rate']?.toString() ??
                                            'N/A'),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(mewsData['blood_pressure']
                                            ?.toString() ??
                                        'N/A'),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(mewsData['oxygen_saturation']
                                            ?.toString() ??
                                        'N/A'),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                        mewsData['urine']?.toString() ?? 'N/A'),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(mewsData['respiratory_rate']
                                            ?.toString() ??
                                        'N/A'),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                        mewsData['mews_score']?.toString() ??
                                            'N/A'),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    currentPage != 1
                        ? ElevatedButton(
                            onPressed: () {
                              setState(() {
                                currentPage -= 1;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryColor,
                                foregroundColor: forthColor,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0))),
                            child: Text(
                              S.of(context)!.previous,
                              style: GoogleFonts.inter(),
                            ))
                        : const SizedBox(),
                    const SizedBox(
                      width: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        currentPage != 1
                            ? ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    currentPage -= 1;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: secondaryColor,
                                    foregroundColor: forthColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0))),
                                child: Text(
                                  S.of(context)!.previous,
                                  style: GoogleFonts.inter(),
                                ))
                            : const SizedBox(),
                        const SizedBox(
                          width: 30,
                        ),
                        DropdownButton<String>(
                          value: currentPage.toString(),
                          elevation: 16,
                          style: TextStyle(color: forthColor),
                          underline: Container(
                            height: 2,
                            color: forthColor,
                          ),
                          items: pageNumList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value != null && value.isNotEmpty) {
                                currentPage = int.parse(value);
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        currentPage != int.parse(maxNumber)
                            ? ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    currentPage += 1;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    backgroundColor: secondaryColor,
                                    foregroundColor: forthColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0))),
                                child: Text(
                                  S.of(context)!.next,
                                  style: GoogleFonts.inter(),
                                ))
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ]);
            }),
      ],
    );
  }
}
