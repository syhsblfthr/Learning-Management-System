import 'package:flutter/material.dart';
import 'profile_page.dart'; // Import halaman ProfilePage

class Homepage extends StatefulWidget {
  final int userId; // ID pengguna untuk halaman profil
  const Homepage({super.key, required this.userId});

  @override
  State<Homepage> createState() => _HomepageState(userId: userId);
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0; // Index awal untuk Bottom Navigation
  final int userId;

  _HomepageState({ required this.userId });

  // Daftar halaman untuk navigasi
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    
    _pages = [
      Center(child: Text('Home Content', style: TextStyle(fontSize: 24))),
      Center(child: Text('Search Content', style: TextStyle(fontSize: 24))),
      Center(child: Text('Notifications Content', style: TextStyle(fontSize: 24))),
      ProfilePage(key: UniqueKey(), userId: userId), // Halaman Profile
    ];
  }

  // Fungsi untuk mengubah halaman saat tombol bottom navigation ditekan
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Tampilkan halaman sesuai index
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Jenis navigasi
        currentIndex: _selectedIndex, // Index saat ini
        onTap: _onItemTapped, // Fungsi untuk mengubah halaman
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blueAccent, // Warna ikon yang dipilih
        unselectedItemColor: Colors.grey, // Warna ikon yang tidak dipilih
      ),
    );
  }
}
