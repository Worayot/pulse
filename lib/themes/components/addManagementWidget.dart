import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddManagementWidget extends StatefulWidget {
  final Function(String) onSave;

  const AddManagementWidget({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  @override
  _AddManagementWidgetState createState() => _AddManagementWidgetState();
}

class _AddManagementWidgetState extends State<AddManagementWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),

          // Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  widget.onSave(_controller.text); // Call onSave callback
                  _controller.clear(); // Clear the text field after saving
                }
              },
              child: Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
