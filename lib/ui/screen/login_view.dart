import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toody/data/auth_data.dart';
import 'package:toody/ui/screen/forgot_password.dart';
import 'package:toody/ui/screen/home.dart';
import 'package:toody/ui/screen/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formSignInKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  String? emailInput = '';
  String? passwordInput = '';
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formSignInKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      "Your Key to Adventure!",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                //email
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: TextFormField(
                      controller: email,
                      onChanged: (value) {
                        setState(() {
                          emailInput = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 10),
                        hintText: 'Enter your Email',
                        hintStyle: const TextStyle(
                          color: Color(0xFF8391A1),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled:
                            true, 
                        fillColor: const Color(
                            0xFFF7F8F9), 
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                //password
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: TextFormField(
                        controller: password,
                        onChanged: (value) {
                          setState(() {
                            passwordInput = value;
                          });
                        },
                        obscureText: !_isPasswordVisible,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(left: 15, right: 10),
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(
                            color: Color(0xFF8391A1),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black26,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF7F8F9),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            child: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.remove_red_eye,
                              color: _isPasswordVisible
                                  ? Colors.black
                                  : const Color(0xFF8391A1),
                            ),
                          ),
                        ),
                      )),
                ),
                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF6A707C),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                //login button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          color: const Color(0xFF1E232C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: () async {
                            if (_formSignInKey.currentState?.validate() ??
                                false) {
                              try {
                                await AuthenticationRemote()
                                    .login(email.text, password.text);
                                
                                if (!context.mounted) return;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );

                                FlutterToastr.show(
                                  'Login Successfully',
                                  context,
                                  position: FlutterToastr.bottom,
                                  duration: FlutterToastr.lengthLong,
                                  backgroundColor:
                                      Colors.green.withOpacity(0.7),
                                );
                              } catch (e) {
                               
                                FlutterToastr.show(
                                  '$e',
                                  context,
                                  position: FlutterToastr.bottom,
                                  duration: FlutterToastr.lengthLong,
                                  backgroundColor: Colors.red.withOpacity(0.7),
                                );
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Login",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Color(0xFFE8ECF4),
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account? ",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupView()));
                      },
                      child: Text(
                        "Register",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF35C2C1),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
