import 'dart:convert';

import 'package:flutter/material.dart';

import 'homepage.dart'; // Import halaman Homepage
import 'register_page.dart'; // Import halaman RegisterPage
import 'networking.dart' as networking;
import 'package:localstorage/localstorage.dart' show initLocalStorage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: {
        '/signup': (ctx) => const RegisterPage(), // Halaman registrasi
      },
      home: const LoginPage(), // Halaman login sebagai default
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _isLoading = false;

  void _toggleLoading() {
    setState(() => _isLoading ^= true);
  }

  void _showError(String message) {
    final Text textMessage = Text(message);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: textMessage),
    );
  }

  void _logIn(BuildContext context) async {
    final String username = _usernameTextController.text.trim();
    final String password = _passwordTextController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showError('Username and password are required');

      return;
    }

    _toggleLoading();

    final response = await networking.post('/authentication/login', {
      'username': username,
      'password': password,
    });

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => Homepage(userId: responseBody['id']),
        ),
      );
    }
    else {
      _showError('Failed to log in with response\'s status code: ${response.statusCode}');
    }

    _toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(
                    Icons.lock,
                    size: 50,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
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
                TextField(
                  controller: _usernameTextController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : () => _logIn(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      debugPrint("Forgot password pressed");
                    },
                    child: const Text("Forgot Password?"),
                  ),
                ),
                const SizedBox(height: 30),
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
    );
  }
}
