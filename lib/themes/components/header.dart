import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Pulse/screens/homeScreen.dart';
import 'package:Pulse/screens/setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/functions/prefFunctions.dart';

class Header extends StatefulWidget {
  final bool renderSettings;
  final Size size;
  const Header(this.size, this.renderSettings, {super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late Future<String> _userNameFuture;
  String _cachedName = '';

  @override
  void initState() {
    super.initState();
    _userNameFuture = _getUserName();
  }

  Future<String> _getUserName() async {
    if (_cachedName.isNotEmpty) {
      return _cachedName;
    }

    Map<String, String> userDetails = await loadUserDetails();
    String name = userDetails['Name'] ?? 'Default Name';
    setState(() {
      _cachedName = name;
    });
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _userNameFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: EdgeInsets.only(
              top: widget.size.height * 0.07,
              bottom: widget.size.height * 0.02,
            ),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: EdgeInsets.only(
              top: widget.size.height * 0.07,
              bottom: widget.size.height * 0.02,
            ),
            child: Center(child: Text('Error loading user name')),
          );
        } else {
          String name = snapshot.data ?? 'Default Name';
          String firstLetter = name.isNotEmpty ? name[0] : 'N/A';

          return Padding(
            padding: EdgeInsets.only(
              top: widget.size.height * 0.07,
              bottom: widget.size.height * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (ModalRoute.of(context)?.settings.name != '/home') {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                      child: Container(
                        width: widget.size.width * 0.13,
                        height: widget.size.width * 0.13,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffBA90CB),
                        ),
                        child: Center(
                          child: Text(
                            firstLetter,
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: widget.size.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: widget.size.width * 0.03),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${S.of(context)!.greeting}\n',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: widget.size.width * 0.06,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: '$name!!',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: widget.size.width * 0.05,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (widget.renderSettings)
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.gear),
                    iconSize: widget.size.width * 0.08,
                    onPressed: () {
                      if (ModalRoute.of(context)?.settings.name !=
                          '/settings') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ),
                        );
                      }
                    },
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}
