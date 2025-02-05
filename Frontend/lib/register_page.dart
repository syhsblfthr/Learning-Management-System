import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({ super.key });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _spacer = const SizedBox(height: 16);

  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _cpasswordTextController = TextEditingController();

  void signup(BuildContext context) async {
    final String usernameValue = _usernameTextController.text;
    final String emailValue = _emailTextController.text;
    final String passwordValue = _passwordTextController.text;
    final String cpasswordValue = _cpasswordTextController.text;

    if (passwordValue != cpasswordValue) {
      // Beri tahu user kalau password yang diberikan tidak sesuai dengan yang di-confirm
      debugPrint('[DEBUG] Passwords do not match\tPassword: $passwordValue\tConfirm Password: $cpasswordValue');
      return;
    }

    Uri uri = Uri.http('10.0.2.2:8000', 'authentication/create');

    var request = http.Request('POST', uri);

    request.bodyFields = {
      'username': usernameValue,
      'email': emailValue,
      'password': passwordValue
    };

    http.StreamedResponse? response;

    try {
      debugPrint('[DEBUG] Sending account creation request...');
      response = await request.send().timeout(Duration(seconds: 10));
    }
    catch (exception) {
      debugPrint('[DEBUG] Exception caught! Exception: $exception');
    }

    if (response != null && response.statusCode == 201) {
      if (context.mounted) {
        Navigator.pop(context); // Kembali ke halaman login
      }
      
      debugPrint('[DEBUG] Berhasil membuat akun!');
    }
    else {
      debugPrint('[DEBUG] Gagal membuat akun!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Heading
            const Text(
              "Create Your Account",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Username
            TextField(
              decoration: InputDecoration(
                labelText: "Username",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              controller: _usernameTextController,
            ),

            _spacer,

            // Email
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              controller: _emailTextController,
            ),

            _spacer,

            // Password
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              controller: _passwordTextController,
            ),

            _spacer,

            // Confirm Password
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Confirm Password",
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              controller: _cpasswordTextController,
            ),

            const SizedBox(height: 30),

            // Tombol Submit
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => signup(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}