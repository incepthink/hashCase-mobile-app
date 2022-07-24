import 'package:hash_case/services/endpoints.dart';
import 'package:hash_case/services/storageService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class API {
  Future<String> getToken() async {
    final response =
        await http.get(Uri.parse('${Endpoints.baseURL}/user/getToken'));
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }

  Future<Object> getVerifiedToken(var address, var signature) async {
    final response = await http.post(
        Uri.parse('${Endpoints.baseURL}/user/verifyToken'),
        body: {'address': address, 'signature': signature});
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body)['message'];
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }

  Future metamaskLogin(var walletAddress) async {
    final response = await http.get(
      Uri.parse('${Endpoints.baseURL}/user/getUser/$walletAddress'),
    );
    if (response.statusCode == 200) {
      print('testing------${response.body}');
      return response.body;
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }

  Future SignIN(String email, String password) async {
    final response = await http.post(
        Uri.parse('${Endpoints.baseURL}/user/login'),
        body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      // print(response.body);
      final res = jsonDecode(response.body);
      print(res);
      await StorageService().JWTStorage.write(key: 'JWT', value: res['token']);
      await StorageService()
          .userStorage
          .write(key: 'user', value: res['user_instance']['id'].toString());
      return response.body;
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }

  Future SignUp(String email, String password) async {
    final response = await http.post(
        Uri.parse('${Endpoints.baseURL}/user/signup'),
        body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      // print('successs');
      // print(response.body);
      final res = jsonDecode(response.body);
      // print(res['token']);
      await StorageService().JWTStorage.write(key: 'JWT', value: res['token']);
      await StorageService()
          .userStorage
          .write(key: 'user', value: res['user_instance']['id'].toString());
      return response.body;
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }

  Future fetchLocalNfts() async {
    var userId = await StorageService().userStorage.read(key: 'user');
    final response = await http.get(
      Uri.parse('${Endpoints.baseURL}/localnft/getNftsOfUser/$userId'),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }

  Future onWalletNfts(var token) async {
    // var userId = await StorageService().userStorage.read(key: 'user');
    // var jwtToken = await StorageService().userStorage.read(key: 'JWT');
    print('is this here');
    final response = await http.post(
        Uri.parse('${Endpoints.baseURL}/merchandise/getallbyIDs'),
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwiaWF0IjoxNjU4NTkyNzY0fQ.AM4mXIgB9YsqvDv26rLJI_-kMZWuOi5EMGPbYDCUMZw',
        },
        body: jsonEncode(token));

    if (response.statusCode == 200) {
      print('entered');
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print('entered else');
      print(response.statusCode);
      throw Exception(response.body);
    }
  }

  Future getCollections() async {
    final response = await http.get(
      Uri.parse('${Endpoints.baseURL}/collections/'),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }

  Future getServerSideProps() async {
    final response = await http.get(
      Uri.parse('${Endpoints.baseURL}/collections/byId/1'),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }
}
