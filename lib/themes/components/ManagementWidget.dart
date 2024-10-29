import 'package:Pulse/screens/HomeScreen.dart';
import 'package:Pulse/services/mews_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ManagementWidget extends StatefulWidget {
  // final Function(String) onSave;
  final String patientID;

  const ManagementWidget({
    Key? key,
    required this.patientID,
  }) : super(key: key);

  @override
  _ManagementWidgetState createState() => _ManagementWidgetState();
}

class _ManagementWidgetState extends State<ManagementWidget> {
  final TextEditingController _controller = TextEditingController();

  final MewsService mewsService = MewsService();
  final uid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            S.of(context)!.addManagement,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),

          // Text Field for entering management details
          TextField(
            controller: _controller,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: S.of(context)!.addNoteDetails,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),

          SizedBox(height: size.height * 0.02),

          // Save Button
          Align(
            alignment: Alignment.centerRight, // Aligns the button to the right
            child: SizedBox(
              width: size.width * 0.3,
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    mewsService.addNewNote(widget.patientID, _controller.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(S.of(context)!.noteSaved),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(S.of(context)!.pleaseFillNote),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  backgroundColor: Color(0xffBA90CB),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  S.of(context)!.save,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
