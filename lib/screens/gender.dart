import 'package:flutter/material.dart';
import 'package:sleep_panda/api/user.dart';
import 'package:sleep_panda/const.dart';
import 'package:sleep_panda/screens/gender.dart';
import 'package:sleep_panda/screens/tanggal.dart';

class GenderPage extends StatelessWidget {
  String name;
  GenderPage({required this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 26, 46), // Background color
      body: SafeArea(
        child: Column(
          children: [
            // Bagian atas untuk teks
            Expanded(
              flex: 3, // Rasio ruang untuk bagian atas
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi $name!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Pilih gender kamu, agar kami bisa mengenal kamu lebih baik.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bagian tengah untuk input
            Expanded(
              flex: 2, // Rasio ruang untuk bagian tengah
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  // Text(
                  //   textAlign: TextAlign.center,
                  //   'Mulai dengan masuk atau mendaftar untuk melihat analisa tidur mu.',
                  //   style: TextStyle(color: Colors.white, fontSize: 15),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Color(0xff272E49),
                            foregroundColor: Colors.white),
                        onPressed: () async {
                          await saveGender('0');
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TanggalPage(),
                          ));
                        },
                        child: Text('Wanita')),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Color(0xff272E49),
                            foregroundColor: const Color.fromARGB(255, 255, 255, 255)),
                        onPressed: () async {
                          await saveGender('1');
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TanggalPage(),
                          ));
                        },
                        child: Text('Pria')),
                  )
                ],
              ),
            )
            ),
          ],
        ),
      ),
    );
  }
}

