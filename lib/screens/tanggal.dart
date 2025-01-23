import 'package:flutter/material.dart';
import 'package:sleep_panda/api/user.dart';
import 'package:sleep_panda/screens/tinggi.dart';

class TanggalPage extends StatelessWidget {
   TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
    }
  }

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
                      "Terima kasih!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Sekarang kapan tanggal lahir kamu?",
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Tanggal Lahir",
                        hintStyle: TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white10,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Select Date',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      controller: _dateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      onSubmitted: (value) async {
                        await saveDob(value);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => TinggiPage(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
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
