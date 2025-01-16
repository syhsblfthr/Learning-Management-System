import 'package:flutter/material.dart';
import 'profile_list.dart'; // Import halaman CRUD

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: const Text('Hello, World!'),
    );

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigasi ke halaman ProfileList
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileList()),
            );
          },
          child: const Text('Go to CRUD Page'),
        ),
      ),
    );
  }
}
