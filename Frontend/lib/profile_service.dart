import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileService {
  final String baseUrl = 'http://10.0.2.2:8000/api'; // URL API Laravel

  // Fetch profil berdasarkan ID
  Future<Map<String, dynamic>?> fetchProfile(int id) async {
    final url = Uri.parse('$baseUrl/profile/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null; // Error handling bisa ditambahkan di sini
      }
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }

  // Update profil berdasarkan ID
  Future<bool> updateProfile(int id, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/profile/$id');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
	  
	  debugPrint('Dapat kode status: ${response.statusCode}');
	  
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
