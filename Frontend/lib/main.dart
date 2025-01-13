import 'package:flutter/material.dart';
import 'register_page.dart'; // Import halaman register
import 'package:http/http.dart' as http;

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
      home: const LoginPage(title: 'Login Page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void logIn() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    Uri uri = Uri.http('192.168.15.133:8000', 'authentication/login');
    try {
      debugPrint('[DEBUG] Trying to send a request to log in with username of "$email" and password of "$password"');

      // Buat requestnya
      http.Request request = http.Request('POST', uri);

      request.bodyFields = {
        'username': email,
        'password': password
      };

      http.StreamedResponse response = await request.send().timeout(Duration(seconds: 10));

      debugPrint('[DEBUG] Response Status Code: ${response.statusCode}');
    }
    catch (exc) {
      debugPrint('[DEBUG] Failed to log in! Exception: $exc');
    }
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
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  controller: emailController
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
                  controller: passwordController
                ),
                const SizedBox(height: 20),

                // Tombol Login
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: logIn,
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
                        // Navigasi ke halaman register
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
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
