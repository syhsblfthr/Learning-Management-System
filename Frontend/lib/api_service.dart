import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://192.168.15.234:8000/api/profiles";
  final headers = {"Content-Type": "application/json"};

  Future<List<dynamic>> fetchProfiles() async {
    final response = await http.get(Uri.parse(baseUrl), headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['data']; // Pastikan sesuai dengan response API Anda
    } else {
      throw Exception("Failed to load profiles");
    }
  }

  Future<void> addProfile(Map<String, String> profileData) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: json.encode(profileData),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to add profile");
    }
  }

  Future<void> updateProfile(int id, Map<String, String> profileData) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: headers,
      body: json.encode(profileData),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update profile");
    }
  }

  Future<void> deleteProfile(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"), headers: headers);
    if (response.statusCode != 200) {
      throw Exception("Failed to delete profile");
    }
  }
}
