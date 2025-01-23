import 'package:flutter/material.dart';
import 'package:sleep_panda/api/user.dart';
import 'package:sleep_panda/screens/profil.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class NextProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 2; // Default index (Profile tab)
  Future<Map<dynamic, dynamic>>? _data;

  @override
  void initState() {
    super.initState();
    // Initialize API call when the widget is first created
    _data = fetchData();
  }

  Future<Map<dynamic, dynamic>> fetchData() async {
    final response = await getUsers(); // Ensure `getUsers()` returns a valid JSON
    print(response);
    return response; // Assume this is already decoded JSON data
  }

  void _onItemTapped(int index) {
    _selectedIndex = index;
  }

  String formatGender(int gender) {
    return gender == 1 ? 'Male' : 'Female';
  }

  String formatDate(String date) {
    try {
      final DateTime parsed = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsed);
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C3C),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
        child: FutureBuilder<Map<dynamic, dynamic>>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              // Parse data from API response
              final profileData = snapshot.data!;
              final name = profileData['name']?.toString() ?? 'N/A';
              final email = profileData['email']?.toString() ?? 'N/A';
              final gender = profileData['gender'] as int? ?? 0;
              final dob = profileData['date_of_birth']?.toString() ?? 'N/A';
              final height = profileData['height'] as int? ?? 0;
              final weight = profileData['weight'] as int? ?? 0;

              return Column(
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
                  SizedBox(height: 24),
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
                    value: formatGender(gender),
                    icon: Icons.female,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    label: 'Date of Birth',
                    value: formatDate(dob),
                    icon: Icons.calendar_today,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    label: 'Height',
                    value: '${height} cm',
                    icon: Icons.height,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    label: 'Weight',
                    value: '${weight} kg',
                    icon: Icons.monitor_weight,
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProflPage(),
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
              );
            } else {
              return Center(child: Text('No data found.'));
            }
          },
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String label;
  final String value;
  final IconData icon;

  CustomTextField({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
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
                child: Icon(widget.icon, color: Colors.white70),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: widget.value,
                  enabled: isEdit,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (widget.label == 'Nama' || widget.label == 'Email')
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white70),
                  onPressed: () {
                    setState(() {
                      isEdit = !isEdit;
                    });
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
