import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'homepage.dart';
import 'register_page.dart'; // Import halaman register

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/signup': (ctx) => const RegisterPage(),
        '/homepage': (ctx) => const Homepage(),
      },
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({ super.key });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  void logIn(BuildContext context) async {
    final String usernameText = _usernameTextController.text;
    final String passwordText = _passwordTextController.text;

    Uri url = Uri.http('192.168.15.133:8000', 'authentication/login');

    var request = http.Request('POST', url);
    request.bodyFields = {
      'username': usernameText,
      'password': passwordText,
    };
    
    var responseTimeout = Duration(seconds: 10);

    try {
      debugPrint('[DEBUG] Sending request...');
      var response = await request.send().timeout(responseTimeout);

      if (response.statusCode == 201) {
        Navigator.pushReplacementNamed(context, '/homepage');
      }

      debugPrint('[DEBUG] Failed to log in with error: ${response.statusCode}');

      // Notify user about the failure to log in
    }
    catch (exception) {
      debugPrint('Caught an unexpected exception! $exception');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue.shade100,
                    child: Icon(
                      Icons.lock,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Judul
                  Text(
                    "Welcome Back!",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Please login to your account",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 40),

                  // Input Email
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    controller: _usernameTextController
                  ),
                  const SizedBox(height: 20),

                  // Input Password
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    controller: _passwordTextController
                  ),
                  const SizedBox(height: 20),

                  // Tombol Login
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => logIn(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Tombol Lupa Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        print("Forgot password pressed");
                      },
                      child: const Text("Forgot Password?"),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Tombol Pendaftaran
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text("Sign Up"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
