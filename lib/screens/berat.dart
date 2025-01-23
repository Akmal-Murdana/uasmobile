import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sleep_panda/api/user.dart';
import 'package:sleep_panda/screens/profil.dart';
import 'package:sleep_panda/screens/profilsngkt.dart';
import 'package:sleep_panda/screens/profleng.dart';

class BeratPage extends StatelessWidget {

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
                      "Terakhir,",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Berapa berat badan kamu?",
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
              flex: 6, // Rasio ruang untuk bagian tengah
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // verticalDirection: VerticalDirection.,
                  children: [
                    SizedBox(
                      width: 85, // Set the desired width
                      height: 50,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Berat",
                          hintStyle: TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Colors.white10,
                          // contentPadding:
                          //     EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onSubmitted: (value) async {
                          await saveWeight(value);
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => ProflScreen(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50, // Set the desired width
                      height: 25,
                      child: Text(
                        textAlign: TextAlign.center,
                        'KG',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
