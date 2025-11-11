import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_foryou/features/login/data/models/client_model.dart';

abstract class LoginRemoteDataSource {
  Future<ClientModel> login(String username, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<ClientModel> login(String username, String password) async {
    final response = await client.post(
      Uri.parse('https://api.example.com/api/login/client'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'usuario': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return ClientModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }
}
