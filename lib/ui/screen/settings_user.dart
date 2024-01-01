import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toody/auth/authentication_service.dart';
import 'package:toody/data/user_data.dart';

class UserSetting extends StatelessWidget {
  UserSetting({super.key});
  final firestoreDatasource = FirestoreDatasource();

  @override
  Widget build(BuildContext context) => FutureBuilder<String>(
        future: firestoreDatasource.getLoggedInUserName(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String fullname = snapshot.data!; // Get fullname
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60.0),
                child: AppBar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  title: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Settings',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(CupertinoIcons.search),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20), 
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/avatar.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 20), 
                        Text(
                          fullname,
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100),
                          child: Text(
                            'to be continued',
                            style: GoogleFonts.poppins(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Divider(
                        thickness: 1.5,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              AuthenticationService().signOut(context);
                            },
                            icon: const Icon(CupertinoIcons.square_arrow_left),
                          ),
                          const SizedBox(
                              width:
                                  8), 
                          const Text(
                            'Sign Out',
                            style: TextStyle(
                                fontSize: 16), 
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator()), 
            );
          }
        },
      );
}
