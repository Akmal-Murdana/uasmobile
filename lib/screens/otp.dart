import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:sleep_panda/const.dart';
import 'package:sleep_panda/api/user.dart';
import 'package:sleep_panda/screens/login.dart';

class OtpVerification extends StatefulWidget {
  final String email;

  const OtpVerification({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  String otpCode = "";
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 34, 63),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 40),
              Text(
                'Verifikasi OTP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Masukkan kode OTP yang telah dikirim ke email ${widget.email}',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              OtpTextField(
                numberOfFields: 6,
                borderColor: second,
                focusedBorderColor: second,
                styles: List.filled(
                  6,
                  TextStyle(color: Colors.white),
                ),
                showFieldAsBox: true,
                borderWidth: 2.0,
                fieldWidth: 45,
                cursorColor: Colors.white,
                enabledBorderColor: Color(0xff272E49),
                fillColor: Color(0xff272E49),
                filled: true,
                onCodeChanged: (String code) {
                  otpCode = code;
                },
                onSubmit: (String verificationCode) {
                  otpCode = verificationCode;
                },
              ),
              SizedBox(height: 40),
              if (isLoading)
                Center(child: CircularProgressIndicator(color: second))
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: second,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (otpCode.length == 6) {
                      setState(() => isLoading = true);
                      try {
                        bool result = await verifyOtp(
                          widget.email,
                          otpCode,
                        );
                        if (result) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetPassword(
                                email: widget.email,
                                otp: otpCode,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Kode OTP tidak valid',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } finally {
                        setState(() => isLoading = false);
                      }
                    }
                  },
                  child: Text(
                    'Verifikasi',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  setState(() => isLoading = true);
                  try {
                    bool result = await sendOtp(widget.email);
                    if (result) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'OTP baru telah dikirim',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: baseColor,
                        ),
                      );
                    }
                  } finally {
                    setState(() => isLoading = false);
                  }
                },
                child: Text(
                  'Kirim Ulang OTP',
                  style: TextStyle(color: second),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetPassword extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPassword({
    Key? key,
    required this.email,
    required this.otp,
  }) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureText = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 34, 63),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Reset Password', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Password Baru',
                  fillColor: Color(0xff272E49),
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  if (value.length < 6) {
                    return 'Password minimal 6 karakter';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureText,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Konfirmasi Password',
                  fillColor: Color(0xff272E49),
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                ),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Password tidak sama';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              if (isLoading)
                Center(child: CircularProgressIndicator(color: second))
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: second,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => isLoading = true);
                      try {
                        bool result = await resetPassword(
                          widget.email,
                          widget.otp,
                          _passwordController.text,
                        );
                        if (result) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Password berhasil direset',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: baseColor,
                            ),
                          );
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Gagal mereset password',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } finally {
                        setState(() => isLoading = false);
                      }
                    }
                  },
                  child: Text(
                    'Reset Password',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}