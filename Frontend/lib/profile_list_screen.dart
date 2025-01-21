import 'package:flutter/material.dart';
import 'api_service.dart';
import 'profile.dart';
import 'profile_form_screen.dart';

class ProfileListScreen extends StatefulWidget {
  @override
  _ProfileListScreenState createState() => _ProfileListScreenState();
}

class _ProfileListScreenState extends State<ProfileListScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Profile>> profiles;

  @override
  void initState() {
    super.initState();
    profiles = apiService.fetchProfiles();
  }

  void _refreshProfiles() {
    setState(() {
      profiles = apiService.fetchProfiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profiles')),
      body: FutureBuilder<List<Profile>>(
        future: profiles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final profile = data[index];
                return ListTile(
                  title: Text(profile.name),
                  subtitle: Text(profile.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileFormScreen(
                                profile: profile,
                                isEdit: true,
                                onSubmit: _refreshProfiles,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          apiService.deleteProfile(profile.id).then((_) {
                            _refreshProfiles();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(child: Text('No profiles found.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileFormScreen(
                isEdit: false,
                onSubmit: _refreshProfiles,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
