import 'package:flutter/material.dart';
import 'api_service.dart';

class ProfileList extends StatefulWidget {
  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  final ApiService apiService = ApiService();
  List profiles = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProfiles();
  }

  // Fungsi untuk mengambil data profil
  void fetchProfiles() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final data = await apiService.fetchProfiles();
      // Pastikan id selalu berupa String
      final processedData = data.map((profile) {
        return {
          ...profile,
          'id': profile['id'].toString(), // Konversi id ke String
        };
      }).toList();

      setState(() {
        profiles = processedData;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching profiles: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profiles")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : profiles.isEmpty
                  ? Center(child: Text("No profiles available"))
                  : ListView.builder(
                      itemCount: profiles.length,
                      itemBuilder: (context, index) {
                        final profile = profiles[index];
                        return ListTile(
                          title: Text(profile['name']),
                          subtitle: Text(profile['email']),
                        );
                      },
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newProfile = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileForm()),
          );
          if (newProfile != null) {
            await apiService.addProfile(newProfile);
            fetchProfiles();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProfileForm extends StatelessWidget {
  final Map<String, String>? initialData;

  ProfileForm({this.initialData});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (initialData != null) {
      nameController.text = initialData!['name'] ?? '';
      emailController.text = initialData!['email'] ?? '';
    }

    return Scaffold(
      appBar: AppBar(title: Text(initialData == null ? "Add Profile" : "Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final profileData = {
                      "name": nameController.text,
                      "email": emailController.text,
                    };

                    if (initialData == null) {
                      Navigator.pop(context, profileData);
                    } else {
                      profileData['id'] = initialData!['id']!;
                      Navigator.pop(context, profileData);
                    }
                  }
                },
                child: Text(initialData == null ? "Add" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

