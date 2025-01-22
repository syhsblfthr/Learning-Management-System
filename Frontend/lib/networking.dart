import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

final _baseURI = 'http://10.0.2.2:8000';

http.Response _saveSession(final http.Response response) {
  debugPrint('[DEBUG] Headers yang ada: ${response.headersSplitValues}');
  
  var setCookieHeaders = response.headersSplitValues['set-cookie'];

  if (setCookieHeaders == null) {
    throw Exception('Invalid response returned by the server.');
  }

  List<String> sessionCookies = [];
  for (final header in setCookieHeaders) {
    sessionCookies.add(header);
  }

  localStorage.setItem('session-cookies', jsonEncode(sessionCookies));

  return response;
}

Map<String, String>? _getSession() {
  final sessionCookiesEncoded = localStorage.getItem('session-cookies');

  if (sessionCookiesEncoded == null) {
    return null;
  }

  final sessionCookiesList = jsonDecode(sessionCookiesEncoded);

  return {
    'set-cookie': sessionCookiesList.join(','),
  };
}

Future<http.Response> post(String path, Map<String, dynamic> data) {
  return http.post(
    Uri.parse('$_baseURI$path'),
    headers: _getSession(),
    body: data,
  ).then(_saveSession);
}

Future<http.Response> get(String path, Map<String, dynamic> data) {
  return http.get(
    Uri.http(_baseURI, path, data),
  ).then(_saveSession);
}

Future<http.Response> put(String path, Map<String, dynamic> data) {
  return http.put(
    Uri.parse('$_baseURI$path'),
    body: data,
  ).then(_saveSession);
}