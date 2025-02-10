import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bottom_items/staff_page.dart';
import 'package:flutter_application_1/dashboard/persistent_bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'http://192.168.20.4:3001'; // Replace with actual IP

  String? _authToken;

  Future<void> setAuthToken(String token) async {
    _authToken = token;
    final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('token', token);
    final success = await prefs.setString('token', token);
    print("Token has been set: $success"); // Debugging purpose
  }

  // Method to get the token from memory or SharedPreferences
  Future<String?> getTokenFromStorage() async {
    if (_authToken != null) {
      // print("Token retrieved from memory: $_authToken");
      return _authToken;
    }
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('token');
    // print("Token retrieved from SharedPreferences: $_authToken");
    return _authToken;
  }

  Future<http.Response> _makeRequest(
    String url,
    String method, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final token = await getTokenFromStorage();
      final defaultHeaders = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': '$token',
      };

      print('Making $method request to: $url');
      print('Body: ${body != null ? jsonEncode(body) : "No Body"}');

      // If DELETE and body is not null, convert body to query params
      if (method.toUpperCase() == 'DELETE' && body != null) {
        final queryString = Uri(queryParameters: body).query;
        url = '$url?$queryString';
      }

      final uri = Uri.parse(url);

      final requestMethods = {
        'POST': () =>
            http.post(uri, headers: defaultHeaders, body: jsonEncode(body)),
        'GET': () => http.get(uri, headers: defaultHeaders),
        'PUT': () =>
            http.put(uri, headers: defaultHeaders, body: jsonEncode(body)),
        'DELETE': () => http.delete(uri, headers: defaultHeaders),
      };

      final requestFunction = requestMethods[method.toUpperCase()];
      if (requestFunction != null) {
        return await requestFunction();
      } else {
        print('Error: Unsupported HTTP method: $method');
        throw Exception('Invalid HTTP method: $method');
      }
    } catch (e) {
      if (e is SocketException) {
        print(e);
        print("No internet connection.");
        throw Exception("No internet connection.");
      } else {
        print("Error during request: $e");
        throw Exception("Something went wrong.");
      }
    }
  }

// Login page of Admin//
  Future<Map<String, dynamic>?> login(
      BuildContext context, String email, String password, String role) async {
    final url = '$baseUrl/admin/login';

    final body = {'email': email, 'password': password};
    print('Request Body: $body');

    try {
      final response = await _makeRequest(url, 'POST', body: body);

      print('Response Status Codessss: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Decoded Data: $data');

        final token = data['token'];
        final userId = data['id']; // Retrieve user ID

        if (token != null) {
          await setAuthToken(token);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successful')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PersistentBottomNavBar()),
          );
          return {
            'success': true,
            'message': 'Login successful',
            'token': token,
            'id': userId
          };
        } else {
          return {'success': false, 'message': 'No token received'};
        }
      } else {
        final data = jsonDecode(response.body);
        return {'success': false, 'message': data['message'] ?? 'Login failed'};
      }
    } catch (e) {
      print('wdgwdgwgd: $e');
      print('Error during login: $e');
      if (e.toString().contains('Connection refused')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Connection refused. Please check your server.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again later.')),
        );
      }
      return {
        'success': false,
        'message': 'An error occurred. Please try again.'
      };
    }
  }

  // create user of admin//

  Future<bool> createUser(Map<String, dynamic> userData) async {
    final url = '$baseUrl/staff/register';
    final body = userData;
    print('Requegfhfst Body: $body');

    try {
      final response = await _makeRequest(url, 'POST', body: body);

      if (response.statusCode == 201) {
        return true;
      } else {
        print("Failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  // get all users list//
  Future<List<Map<String, String>>> fetchUsers() async {
    final url = '$baseUrl/staff/users';
    try {
      final response = await _makeRequest(url, 'GET');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('asd: $data');
        final users = data['users'] as List;
        print("Fetched Users: $users");

        return users.map((user) {
          return {
            "id": user["id"].toString(),
            "name": user["username"]?.toString() ?? "Unknown",
            "email": user["email"]?.toString() ?? "No Email",
            "contact": user["contact_number"]?.toString() ?? "No Contact",
            "role": user["role"]?.toString() ?? "User",
          };
        }).toList();
      } else {
        throw Exception('Failed to fetch users: ${response.reasonPhrase}');
      }
    } catch (e) {
      print("Error fetching users: $e");
      return [];
    }
  }

  Future<bool> updateUser(
      String userId, Map<String, dynamic> updatedstaff) async {
    final Uri url =
        Uri.parse('$baseUrl/staff/user/$userId'); // Include userId in the URL
    print("Updated Task Data: $updatedstaff");

    try {
      final response = await _makeRequest(
        url.toString(),
        'PUT', // Use 'PUT' or 'PATCH' based on your API
        body: updatedstaff, // Send the body as JSON
      );

      if (response.statusCode == 200) {
        return true; // Successfully updated
      } else {
        print(
            'Failed to update user: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }

  Future<void> deleteUserFromApi(String staffId, VoidCallback onDelete) async {
    final Uri url = Uri.parse('$baseUrl/staff/user/$staffId');
    print('asd:$staffId');
    try {
      final response =
          await _makeRequest(url.toString(), "DELETE"); // Direct delete request

      if (response.statusCode == 200) {
        print('Staff deleted successfully.');
        onDelete(); // Notify UI update
      } else {
        final data = jsonDecode(response.body);
        throw Exception(
            'Error deleting staff: ${data['message'] ?? response.body}');
      }
    } catch (e) {
      print('Error during staff deletion: $e');
      rethrow;
    }
  }


  int totalPages = 1; // Store total pages globally
  Future<List<Map<String, String>>> fetchcategory({int page = 1, int limit = 10}) async {
    final url = '$baseUrl/pro_category/all_category?page=$page&limit=$limit';
    print('Fetching: $url');

    try {
      final response = await _makeRequest(url, 'GET');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        totalPages = data["totalPages"]; // Update total pages

        final category = data["data"] as List;
        return category.map((cat) {
          return {
            "id": cat["id"]?.toString() ?? "0",
            "category_name": cat["category_name"]?.toString() ?? "",
            "description": cat["description"]?.toString() ?? "",
          };
        }).toList();
      } else {
        throw Exception('Failed to fetch categories: ${response.reasonPhrase}');
      }
    } catch (e) { 
      print("Error fetching categories: $e");
      return [];
    }
  }


  // create category //
  Future<bool> createCategory(Map<String, dynamic> categorydata) async {
    final url = '$baseUrl/pro_category/insert_category';
    final body = categorydata;
    print('Requegfhfst Body: $body');

    try {
      final response = await _makeRequest(url, 'POST', body: body);

      if (response.statusCode == 201) {
        return true;
      } else {
        print("Failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  // // update category//
  Future<bool> updateCategory(
      String CategoryId, Map<String, dynamic> updatedCategory) async {
    final Uri url = Uri.parse(
        '$baseUrl/pro_category/update_category/$CategoryId'); // Include userId in the URL
    print("Updated Task Data: $updatedCategory");

    try {
      final response = await _makeRequest(
        url.toString(),
        'PUT', // Use 'PUT' or 'PATCH' based on your API
        body: updatedCategory, // Send the body as JSON
      );

      if (response.statusCode == 200) {
        return true; // Successfully updated
      } else {
        print(
            'Failed to update user: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }

  // Delete category//

  Future<void> deleteCatgeoryFromApi(
      String categoryId, VoidCallback onDelete) async {
    final Uri url = Uri.parse('$baseUrl/pro_category/del_category/$categoryId');

    try {
      final response = await _makeRequest(url.toString(), "DELETE");

      if (response.statusCode == 200) {
        print('Category deleted successfully.');
        onDelete(); // Update UI after deletion
      } else {
        final data = jsonDecode(response.body);
        throw Exception(
            'Error deleting Category: ${data['message'] ?? response.body}');
      }
    } catch (e) {
      print('Error during Category deletion: $e');
      rethrow;
    }
  }

// Supplier list page//

  Future<List<Map<String, dynamic>>> fetchsupplier() async {
    final url = '$baseUrl/supplier/sup_all';
    try {
      final response = await _makeRequest(url, 'GET');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('asd: $data');
        final supplier = data as List;
        print("Fetched Users: $supplier");

        return supplier.map((supplier) {
          return {
            "company_name": supplier["company_name"] ?? "Unknown",
            "phone_number": supplier["phone_number"] ?? "No Contact",
            "email": supplier["email"] ?? "No Email",
            "address": supplier["address"] ?? "No Address",
            "supplier_gst_number": supplier["supplier_gst_number"] ?? "No GST",
            "status": supplier["status"] ?? "Inactive",
          };
        }).toList();
      } else {
        throw Exception('Failed to fetch users: ${response.reasonPhrase}');
      }
    } catch (e) {
      print("Error fetching users: $e");
      return [];
    }
  }

  // create supplier//
   Future<bool> createSupplier(Map<String, dynamic> supplierData) async {
  final url = '$baseUrl/supplier/sup_insert';
  final body = supplierData;

   try {
      final response = await _makeRequest(url, 'POST', body: body);

      if (response.statusCode == 201) {
        return true;
      } else {
        print("Failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }

}
}