import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toody/data/auth_data.dart';
import 'package:toody/ui/screen/home.dart';
import 'package:toody/ui/screen/login_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formSignUpKey = GlobalKey<FormState>();
  final fullname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  String? nameInput = '';
  String? emailInput = '';
  String? passwordInput = '';
  String? confirmPasswordInput = '';
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formSignUpKey,
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
                      "Take the First Step!",
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                //username
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
                      controller: fullname,
                      onChanged: (value) {
                        setState(() {
                          nameInput = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 10),
                        hintText: 'Username',
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
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
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
                          return 'Please enter Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 10),
                        hintText: 'Email',
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
                          return 'Please enter Password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 10),
                        hintText: 'Password',
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
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                //confirm password
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
                      controller: confirmPassword,
                      onChanged: (value) {
                        setState(() {
                          confirmPasswordInput = value;
                        });
                      },
                      obscureText: !_isConfirmPasswordVisible,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter confirm Password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 10),
                        hintText: 'Confirm password',
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
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                          child: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.remove_red_eye,
                            color: _isConfirmPasswordVisible
                                ? Colors.black
                                : const Color(0xFF8391A1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                //register button
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
                            if (_formSignUpKey.currentState?.validate() ??
                                false) {
                              try {
                                if (password.text != confirmPassword.text) {
                                  FlutterToastr.show(
                                    'Password and Confirm Password do not match',
                                    context,
                                    backgroundColor: Colors.red.shade300,
                                    position: FlutterToastr.bottom,
                                    duration: FlutterToastr.lengthLong,
                                  );
                                } else {
                                  await AuthenticationRemote().signup(
                                      fullname.text, email.text, password.text);

                                  if (!context.mounted) return;
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                  FlutterToastr.show(
                                    'Registered Successfully and You are Loggin',
                                    context,
                                    backgroundColor: Colors.green.shade300,
                                    position: FlutterToastr.bottom,
                                    duration: FlutterToastr.lengthLong,
                                  );
                                }
                              } catch (e) {
                                FlutterToastr.show(
                                  '$e',
                                  context,
                                  backgroundColor: Colors.red.shade300,
                                  position: FlutterToastr.bottom,
                                  duration: FlutterToastr.lengthLong,
                                );
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Register",
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
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 70),
                    Text(
                      "Already have an account? ",
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
                                builder: (context) => const LoginView()));
                      },
                      child: Text(
                        "Login",
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
