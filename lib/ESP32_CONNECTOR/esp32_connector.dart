import 'package:http/http.dart' as http;
import 'dart:convert';

class ESP32ApiClient {
  String baseUrl = 'http://192.168.0.105';//default url
  
  ESP32ApiClient(this.baseUrl);

  // Helper for error handling
  Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
  }

  // GET /api/status - Get all ports
  Future<Map<String, dynamic>> getStatus() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/status'),
      headers: {'Content-Type': 'application/json'},
    ).timeout(Duration(seconds: 5));
    return _handleResponse(response);
  }

  // GET /api/port/{id} - Get single port
  Future<Map<String, dynamic>> getPort(int portId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/port/$portId'),
      headers: {'Content-Type': 'application/json'},
    ).timeout(Duration(seconds: 5));
    return _handleResponse(response);
  }

  // POST /api/port/{id}/on - Turn on
  Future<Map<String, dynamic>> turnOn(int portId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/port/$portId/on'),
      headers: {'Content-Type': 'application/json'},
    ).timeout(Duration(seconds: 5));
    return _handleResponse(response);
  }

  // POST /api/port/{id}/off - Turn off
  Future<Map<String, dynamic>> turnOff(int portId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/port/$portId/off'),
      headers: {'Content-Type': 'application/json'},
    ).timeout(Duration(seconds: 5));
    return _handleResponse(response);
  }

  // POST /api/port/{id}/dim - Set brightness
  Future<Map<String, dynamic>> setDim(int portId, int value) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/port/$portId/dim'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'value': value}),
    ).timeout(Duration(seconds: 5));
    return _handleResponse(response);
  }

  // POST /api/port/{id}/schedule - Set schedule
  Future<Map<String, dynamic>> setSchedule(int portId, int onHour, int offHour) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/port/$portId/schedule'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'on': onHour, 'off': offHour}),
    ).timeout(Duration(seconds: 5));
    return _handleResponse(response);
  }

  // GET /api/energy/daily - Get daily energy
  Future<Map<String, dynamic>> getDailyEnergy(String date) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/energy/daily?date=$date'),
      headers: {'Content-Type': 'application/json'},
    ).timeout(Duration(seconds: 5));
    return _handleResponse(response);
  }

  // GET /api/energy/current - Get current energy
  Future<Map<String, dynamic>> getCurrentEnergy() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/energy/current'),
      headers: {'Content-Type': 'application/json'},
    ).timeout(Duration(seconds: 5));
    return _handleResponse(response);
  }

  // GET /api/info - Get device info
  Future<Map<String, dynamic>> getDeviceInfo() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/info'),
      headers: {'Content-Type': 'application/json'},
    ).timeout(Duration(seconds: 5));
    return _handleResponse(response);
  }

  // POST /api/reset - Factory reset
  Future<Map<String, dynamic>> factoryReset() async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/reset'),
      headers: {'Content-Type': 'application/json'},
    ).timeout(Duration(seconds: 5));
    return _handleResponse(response);
  }
}
