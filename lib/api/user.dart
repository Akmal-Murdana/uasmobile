import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sleep_panda/const.dart';
import 'package:sleep_panda/api/local_storage.dart';

Future<void> logout() async {
  clearData();
}

Future<bool> register(String email, String password) async {
  var data = {'email': email, 'password': password};

  var client = http.Client();

  try {
    var res = await client.post(
      Uri.parse("$baseUrl/register/"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: json.encode(data),
    );

    if (res.statusCode == 200) {
      await saveData('email', email);
      await saveData('access_token', json.decode(res.body)["access_token"]);
      return true;
    } else {
      print("Error: ${res.statusCode}");
      print("Response body: ${res.body}");
      return false;
    }
  } catch (e) {
    print("Error: $e");
    return false;
  } finally {
    client.close();
  }
}

Future<bool> login(String email, String password) async {
  var data = {'email': email, 'password': password};

  var client = http.Client();

  try {
    var res = await client.post(
      Uri.parse("$baseUrl/login/"), // Replace with the correct login endpoint
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(data),
    );

    if (res.statusCode == 200) {
      await saveData('email', email);
      await saveData('access_token', json.decode(res.body)["access_token"]);
      print("Login successful!");
      print(
          "Response: ${res.body}"); // Optionally log the response for debugging
      return true;
    } else {
      print("Login failed with status code: ${res.statusCode}");
      print("Response body: ${res.body}");
      return false;
    }
  } catch (e) {
    print("Error: $e");
    return false;
  } finally {
    client.close();
  }
}
Future<bool> verifyOtp(String email, String otp) async {
  // Implement your OTP verification logic here
  return true; // Return true if OTP is valid
}

Future<bool> resetPassword(String email, String otp, String newPassword) async {
  // Implement your password reset logic here
  return true; // Return true if password reset is successful
}

Future getUsers() async {
  var token = await getToken('access_token');
  var email = await getToken('email');
  print(token);
  try {
    var res = await http.get(Uri.parse("$baseUrl/user/$email"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },);
    if (res.statusCode == 200) {
      return json.decode(res.body);
    } 
  } catch (e) {
    return e;
  }
}

Future<bool> sendOtp(String email) async {
  var response = await http.post(
      Uri.parse('$baseUrl/request-otp/?email=$email'),
      body: jsonEncode({'email': email}));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> saveName(String name) async {
  var email = await getToken('email');
  var token = await getToken('access_token');
  var response = await http.put(
      Uri.parse('$baseUrl/save-name/'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({'email': email, 'name': name}));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> saveGender(String gender) async {
  var email = await getToken('email');
  var token = await getToken('access_token');
  var response = await http.put(
      Uri.parse('$baseUrl/save-gender/'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({'email': email, 'gender': gender}));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> saveDob(String dob) async {
  var email = await getToken('email');
  var token = await getToken('access_token');

  var response = await http.put(
      Uri.parse('$baseUrl/save-dob/'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({'email': email, 'date_of_birth': dob}));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> saveWeight(String weight) async {
  var email = await getToken('email');
  var token = await getToken('access_token');

  var response = await http.put(
      Uri.parse('$baseUrl/save-weight/'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({'email': email, 'weight': weight}));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> saveHeight(String height) async {
  var email = await getToken('email');
  var token = await getToken('access_token');

  var response = await http.put(
      Uri.parse('$baseUrl/save-height/'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({'email': email, 'height': height}));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
