import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Pulse/provider.dart'; // Import LocaleProvider

class FlagWidget extends StatefulWidget {
  const FlagWidget({super.key});

  @override
  _FlagWidgetState createState() => _FlagWidgetState();
}

class _FlagWidgetState extends State<FlagWidget> {
  int _selectedIndex = 0; // Default index

  @override
  void initState() {
    super.initState();
    _loadSavedIndex();
  }

  // Load saved button index from shared preferences
  Future<void> _loadSavedIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedIndex = prefs.getInt('selectedButtonIndex') ?? 0;
    });
  }

  // Save the selected button index to shared preferences
  Future<void> _saveSelectedIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedButtonIndex', index);
  }

  void _onFlagPressed(int index) {
    // Update locale based on index
    Locale newLocale =
        index == 0 ? const Locale('th', '') : const Locale('en', '');

    // Update the locale in LocaleProvider
    Provider.of<LocaleProvider>(context, listen: false).setLocale(newLocale);

    setState(() {
      _selectedIndex = index;
      _saveSelectedIndex(index); // Save the selected button index
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Get the screen size

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Thai flag button
          GestureDetector(
            onTap: () => _onFlagPressed(0),
            child: Container(
              height: size.width * 0.14,
              decoration: BoxDecoration(
                border: _selectedIndex == 0
                    ? Border.all(color: Colors.black, width: 2)
                    : null,
                shape: BoxShape.rectangle,
              ),
              child: Image.asset(
                'assets/images/thai_flag.png', // Replace with your Thai flag image path
                width: size.width * 0.2,
                height: size.width * 0.2,
              ),
            ),
          ),
          SizedBox(width: size.width * 0.07), // Add some space between flags

          // English flag button
          GestureDetector(
            onTap: () => _onFlagPressed(1),
            child: Container(
              height: size.width * 0.14,
              decoration: BoxDecoration(
                border: _selectedIndex == 1
                    ? Border.all(color: Colors.black, width: 2)
                    : null,
                shape: BoxShape.rectangle,
              ),
              child: Image.asset(
                'assets/images/english_flag.png', // Replace with your English flag image path
                width: size.width * 0.2,
                height: size.width * 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
