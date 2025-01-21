import 'package:flutter/material.dart';
import 'profile_service.dart';

class ProfilePage extends StatefulWidget {
  final int userId; // ID user untuk fetch data profil
  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final ProfileService _profileService = ProfileService();

  bool _isLoading = false;

  // Controller untuk form input
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nisController = TextEditingController();
  TextEditingController kotaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProfile(); // Ambil data profil saat halaman diinisialisasi
  }

  // Fungsi untuk mengambil data profil
  Future<void> _fetchProfile() async {
    setState(() => _isLoading = true);
    try {
      final profile = await _profileService.fetchProfile(widget.userId);
      if (profile != null) {
        setState(() {
          usernameController.text = profile['username'];
          emailController.text = profile['email'];
          debugPrint('Hi');
          nisController.text = profile['nomor_induk_sekolah'];
          debugPrint('Hello');
          kotaController.text = profile['kota'];
        });
      } else {
        _showSnackbar('Failed to fetch profile data');
      }
    } catch (e) {
      _showSnackbar('Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Fungsi untuk mengupdate data profil
  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final isSuccess = await _profileService.updateProfile(widget.userId, {
        'username': usernameController.text,
        'email': emailController.text,
        'nomor_induk_sekolah': nisController.text,
        'kota': kotaController.text,
      });

      if (isSuccess) {
        _showSnackbar('Profile updated successfully');
      } else {
        _showSnackbar('Failed to update profile');
      }
    } catch (e) {
      _showSnackbar('Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Fungsi untuk menampilkan snackbar
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email cannot be empty';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: nisController,
                      decoration:
                          const InputDecoration(labelText: 'Nomor Induk Sekolah (NIS)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'NIS cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: kotaController,
                      decoration: const InputDecoration(labelText: 'Kota'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'City cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _updateProfile,
                      child: const Text('Update Profile'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
