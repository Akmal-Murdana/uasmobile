import 'package:flutter/material.dart';
import 'package:sleep_panda/screens/profleng.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  late String name;
  late String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C3C),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1C1C3C),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Jurnal Tidur',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nights_stay),
            label: 'Sleep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 16),
            CustomTextField(
              label: 'Nama',
              value: name,
              icon: Icons.person,
            ),
            SizedBox(height: 16),
            CustomTextField(
              label: 'Email',
              value: email,
              icon: Icons.email,
            ),
            SizedBox(height: 16),
            CustomTextField(
              label: 'Gender',
              value: 'Female',
              icon: Icons.female,
            ),
            SizedBox(height: 16),
            CustomTextField(
              label: 'Date of birth',
              value: '30 May 1994',
              icon: Icons.calendar_today,
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NextProfil(),
                          ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1CC5A0), // Button color
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  late bool isEdit = false;
  CustomTextField({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF292B4D),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(icon, color: Colors.white70),
              ),
              Expanded(
                // child: Text(
                //   value,
                //   style: TextStyle(color: Colors.white, fontSize: 16),
                // ),
                child: TextFormField(
                  initialValue: value,
                  // readOnly: isEdit,
                  enabled: isEdit,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              if (label == 'Nama' || label == 'Email') IconButton(
                icon: Icon(Icons.edit, color: Colors.white70),
                onPressed: () {
                  isEdit = !isEdit;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
