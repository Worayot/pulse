import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/themes/components/flagwidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _nurseIdController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nurseIdController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffFFDDEC),
                  borderRadius:
                      BorderRadius.circular(20), // Adjust the radius as needed
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                child: Column(
                  children: [
                    Text(
                      S.of(context)!.login,
                      style: GoogleFonts.inter(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors
                                .white, // Set underline color to white when focused
                          ),
                        ),
                        labelText: S.of(context)!.email,
                        floatingLabelStyle: GoogleFonts.inter(
                          color: Colors
                              .black, // Ensure label color stays the same when focused
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context)!.plsEnterYourEmail;
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return S.of(context)!.plsEnterTheValidEmail;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _nurseIdController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText:
                            '${S.of(context)!.password} (${S.of(context)!.nurseID})',
                        floatingLabelStyle: GoogleFonts.inter(
                          color: Colors.black,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context)!.plsEnterYourNurseIDAsPassword;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    _login(context),
                    SizedBox(
                      height: 30,
                    ),
                    FlagWidget()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _login(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffE8A0BF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: Size(MediaQuery.of(context).size.width * 0.05, 60),
        elevation: 0,
      ),
      onPressed: () async {
        await AuthService().signin(
            email: _emailController.text,
            password: _nurseIdController.text,
            context: context);
      },
      child: Text(
        S.of(context)!.login,
        style: GoogleFonts.inter(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget flag(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Action to set the language to Thai
          },
          child: Image.asset(
            'assets/images/thai_flag.png',
            width: 50,
            height: 50,
          ),
        ),
        SizedBox(width: 16), // Space between flags
        GestureDetector(
          onTap: () {
            // Action to set the language to English
          },
          child: Image.asset(
            'assets/images/english_flag.png',
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }
}
