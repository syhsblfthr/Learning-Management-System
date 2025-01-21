import 'dart:convert';
import 'package:http/http.dart' as http;
import 'profile.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api'; // URL API Laravel

  Future<List<Profile>> fetchProfiles() async {
    final response = await http.get(Uri.parse('$baseUrl/profiles'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Profile.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load profiles');
    }
  }

  Future<Profile> createProfile(Profile profile) async {
    final response = await http.post(
      Uri.parse('$baseUrl/profiles'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(profile.toJson()),
    );
    if (response.statusCode == 201) {
      return Profile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create profile');
    }
  }

  Future<void> updateProfile(int id, Profile profile) async {
    final response = await http.put(
      Uri.parse('$baseUrl/profiles/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(profile.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }

  Future<void> deleteProfile(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/profiles/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete profile');
    }
  }
}
