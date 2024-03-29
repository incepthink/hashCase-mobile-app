import 'package:hash_case/HiveDB/NFT/HcNFT.dart';
import 'package:hash_case/HiveDB/NFT/HcNFTList.dart';
import 'package:hash_case/services/endpoints.dart';
import 'package:hash_case/services/storageService.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../HiveDB/NFT/HcNFT.dart';
import '../HiveDB/NFT/NFT2.dart';
import '../HiveDB/UserData/UserData.dart';

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

  Future<bool> SignIN(String email, String password) async {
    final response = await http.post(
        Uri.parse('${Endpoints.baseURL}/user/login'),
        body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      try {
        final res = jsonDecode(response.body);
        //store userData in Hive
        final globalBox = Hive.box('globalBox');
        if (globalBox.containsKey('userData')) globalBox.delete('userData');
        final UserData userData = UserData.fromMap(res);
        await globalBox.put('userData', userData);

        // ===DEPRECIATED===
        // await StorageService.JWTStorage.write(key: 'JWT', value: res['token']);
        // await StorageService.userStorage
        //     .write(key: 'user', value: res['user_instance']['id'].toString());

        print('===Updated User Data===');
        print(userData);
        return Future.value(true);
      } catch (e) {
        print("Error updating USER PROFILE: ${e.toString()}");
        return Future.value(false);
      }
    }
    print(response.body);
    return Future.value(false);
    throw Exception(response.body);
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
      await StorageService.JWTStorage.write(key: 'JWT', value: res['token']);
      await StorageService.userStorage
          .write(key: 'user', value: res['user_instance']['id'].toString());
      return response.body;
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }

  Future fetchLocalNfts() async {
    final globalBox = Hive.box('globalBox');
    final UserData userData = globalBox.get('userData');
    // var userId = await StorageService.userStorage.read(key: 'user');
    int userID = userData.id;

    final response = await http.get(
      Uri.parse('${Endpoints.baseURL}/localnft/getNftsOfUser/$userID'),
    );
    if (response.statusCode == 200) {
      print('===success===');
      List<NFT2> localNFTs = [];
      List<dynamic> data = jsonDecode(response.body);
      data.forEach((nft) {
        // var test = NFT2.fromMap(element);
        // print(test);
        localNFTs.add(NFT2.fromMap(nft));
      });
      userData.myNFTList = localNFTs;
      await globalBox.put('userData', userData);
      return response.body;
    } else {
      print("===ERROR===");
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
    print('===getCollectionsPassed===');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final globalBox = Hive.box('globalBox');
      final List<HcNFT> nftList = [];
      final List<dynamic> data = jsonDecode(response.body);
      print(data);
      data.forEach((element) {
        final x = HcNFT.fromMap(element);
        print(x);
        nftList.add(x);
      });
      final value = HcNFTList(hcNFTList: nftList);
      await globalBox.put('HcNFTs', value);
      return jsonDecode(response.body);
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

  signOut() {
    final globalBox = Hive.box('globalBox');
    globalBox.delete('userData');
  }
}
