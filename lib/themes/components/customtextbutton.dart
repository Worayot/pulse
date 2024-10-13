import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Pulse/provider.dart'; // Import LocaleProvider
import 'package:Pulse/themes/components/textbuttonwithdivider.dart';

class ButtonGroup extends StatefulWidget {
  const ButtonGroup({super.key});

  @override
  _ButtonGroupState createState() => _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {
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
      _selectedIndex = prefs.getInt('selectedButtonIndex') ??
          0; // Default to 0 if no saved value
    });
  }

  // Save the selected button index to shared preferences
  Future<void> _saveSelectedIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedButtonIndex', index);
  }

  void _onButtonPressed(int index) {
    // Update locale based on index
    Locale newLocale;
    if (index == 0) {
      newLocale = const Locale('th', ''); // Thai
    } else {
      newLocale = const Locale('en', ''); // English
    }

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

    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () => {_onButtonPressed(0), _selectedIndex == 0},
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.02),
              child: TextButtonWithDivider(
                paddingAboveDivider: size.height * 0.02,
                text: 'ไทย',
                isPressed: _selectedIndex == 0,
                onPressed: () {
                  _onButtonPressed(0);
                },
              ),
            ),
          ),
          TextButton(
            onPressed: () => {_onButtonPressed(1), _selectedIndex == 1},
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.02),
              child: TextButtonWithDivider(
                paddingAboveDivider: size.height * 0.02,
                text: 'English',
                isPressed: _selectedIndex == 1,
                onPressed: () {
                  _onButtonPressed(1);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
