import 'package:flutter/material.dart';
import 'package:hash_case/GlobalConstants.dart';
import 'package:hash_case/GlobalWidgets/custom_snackbar.dart';
import 'package:hash_case/HiveDB/NFT/Catalogue.dart';
import 'package:hash_case/HiveDB/NFT/Merchandise.dart';
import 'package:hash_case/services/endpoints.dart';
import 'package:hash_case/services/models.dart';
import 'package:hash_case/services/smartContractFunctions.dart';
import 'package:hash_case/services/storageService.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:multiple_result/multiple_result.dart';

import '../HiveDB/NFT/Catalogue.dart';
import '../HiveDB/NFT/NFT.dart';
import '../HiveDB/UserData/UserData.dart';

class API {
  static Future<String> getToken() async {
    final response =
        await http.get(Uri.parse('${Endpoints.baseURL}/user/getToken'));
    if (response.statusCode == 200) {
      // print(response.body);
      return response.body;
    } else {
      // print(response.body);
      throw Exception(response.body);
    }
  }

  static Future<Object> getVerifiedToken(var address, var signature) async {
    final response = await http.post(
        Uri.parse('${Endpoints.baseURL}/user/verifyToken'),
        body: {'address': address, 'signature': signature});
    if (response.statusCode == 200) {
      // print(response.body);
      await StorageService.JWTStorage.write(
          key: 'JWT', value: jsonDecode(response.body)['token']);
      return jsonDecode(response.body)['message'];
    } else {
      // print(response.body);
      throw Exception(response.body);
    }
  }

  static Future<bool> metamaskLogin(var walletAddress) async {
    final response = await http.get(
      Uri.parse('${Endpoints.baseURL}/user/getUser/$walletAddress'),
    );
    if (response.statusCode == 200) {
      try {
        final res = jsonDecode(response.body);
        // print(res);
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
        // print(userData);
        return Future.value(true);
      } catch (e) {
        print("Error updating USER PROFILE: ${e.toString()}");
        return Future.value(false);
      }

      // return response.body;
    } else {
      // print(response.body);
      return Future.value(false);
      // throw Exception(response.body);
    }
  }

  static Future<Result<Exception, bool>> signIn(
      String email, String password) async {
    try {
      final globalBox = Hive.box('globalBox');
      final uri = Uri.parse('${Endpoints.baseURL}/user/login');
      final response =
          await http.post(uri, body: {'email': email, 'password': password});
      final data = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
          if (globalBox.containsKey('userData')) globalBox.delete('userData');
          final UserData userData = UserData.fromMap(data);
          await globalBox.put('userData', userData);
          await StorageService.JWTStorage.write(
              key: 'JWT', value: data['token']);
          return const Success(true);
        case 500:
          String message;
          switch (data["message"]) {
            case "User does not exist":
              message = "User with given credentials does not exist!";
              break;
            case "Wrong Password":
              message = "Wrong Password";
              break;
            default:
              message = "Error Signing in";
          }
          return Error(Exception(message));
        default:
          return Error(Exception(data["message"]));
      }
    } catch (e) {
      debugPrint("Unhandled Exception");
      return Error(Exception(e.toString()));
    }
  }

  static Future signUp(String email, String password) async {
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

  static Future fetchEmailNFTs() async {
    var address = await StorageService.JWTStorage.read(key: 'wallet_address');
    if (address == null) {
      final globalBox = Hive.box('globalBox');
      final UserData userData = globalBox.get('userData');
      // var userId = await StorageService.userStorage.read(key: 'user');
      int userID = userData.id;

      final response = await http.get(
        Uri.parse('${Endpoints.baseURL}/localnft/getNftsOfUser/$userID'),
      );
      if (response.statusCode == 200) {
        print('===SUCCESS fetchLocalNfts===');
        List<NFT> localNFTs = [];
        if (userData.myNFTList.isNotEmpty) localNFTs = userData.myNFTList;
        List<dynamic> data = jsonDecode(response.body);
        data.forEach((value) {
          NFT nft = NFT.fromMap(value);
          var preExistingNft = localNFTs
              .firstWhereOrNull((element) => element.nftID == nft.nftID);
          if (preExistingNft == null) localNFTs.add(nft);
        });
        userData.myNFTList = localNFTs;
        await globalBox.put('userData', userData);
        return response.body;
      } else {
        print("===ERROR fetchLocalNfts===");
        // print(response.body);
        throw Exception(response.body);
      }
    }
  }

  static Future fetchWalletNfts() async {
    var address = await StorageService.JWTStorage.read(key: 'wallet_address');
    if (address != null) {
      final token = await SmartContractFunction.smartContracts();
      final jwtToken = await StorageService.JWTStorage.read(key: 'JWT');
      final globalBox = Hive.box('globalBox');

      final UserData userData = globalBox.get('userData');
      final response = await http.post(
          Uri.parse('${Endpoints.baseURL}/merchandise/getallbyIDs'),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $jwtToken',
          },
          body: jsonEncode(token));

      if (response.statusCode == 200) {
        // print(response.body);
        print('===success===');
        List<NFT> localNFTs = [];
        List<dynamic> data = jsonDecode(response.body);
        for (var nft in data) {
          if (nft != null) {
            localNFTs.add(NFT(
              merchandise: Merchandise.fromMap(nft),
              nftID: -1,
              id: -1,
              updatedAt: DateTime.parse('2000-01-01 00:00:01'),
              userID: -1,
              createdAt: DateTime.parse('2000-01-01 00:00:01'),
            ));
          }
        }
        userData.myNFTList = localNFTs;
        await globalBox.put('userData', userData);
        return response.body;
        // return jsonDecode(response.body);
      } else {
        print(response.statusCode.toString());
        throw Exception(response.body);
      }
    }
  }

  static Future getCollections() async {
    final response = await http.get(
      Uri.parse('${Endpoints.baseURL}/collections/'),
    );
    print('===getCollectionsPassed===');
    if (response.statusCode == 200) {
      final catalogueBox = Hive.box<Catalogue>('catalogueNFT');
      final List<dynamic> res = jsonDecode(response.body);
      res.forEach((data) {
        final nft = Catalogue.fromMap(data);
        catalogueBox.put(nft.id, nft);
      });
      return jsonDecode(response.body);
    } else {
      // print(response.body);
      throw Exception(response.body);
    }
  }

  static Future getServerSideProps() async {
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

  signOut() async {
    final globalBox = Hive.box('globalBox');
    globalBox.delete('userData');
    await StorageService.JWTStorage.deleteAll();
  }

  static Future<EthereumMetadata> ethereumConnect() async {
    try {
      String _uri = '';
      final connector = WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        clientMeta: const PeerMeta(
          name: 'WalletConnect',
          description: 'WalletConnect Developer App',
          url: 'https://walletconnect.org',
          icons: [
            'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ],
        ),
      );

      await connector.createSession(
        chainId: 4160,
        onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrl(
            Uri.parse(uri),
          );
        },
      );

      await StorageService.JWTStorage.write(
          key: 'wallet_address', value: connector.session.accounts[0]);

      return EthereumMetadata(
        address: connector.session.accounts[0],
        uri: _uri,
        connector: connector,
      );
    } catch (e) {
      showCustomSnackBar(text: e.toString().substring(23), color: kColorDanger);
      Uri metamaskDownloadLink = Uri.parse("https://metamask.io/download/");
      throw 'Could not launch $metamaskDownloadLink';
    }
  }

  static Future<bool> ethereumSign(EthereumMetadata ethMeta) async {
    try {
      if (!ethMeta.connector.connected) {
        print('not connected');
        API.ethereumConnect();
      }
      final provider = EthereumWalletConnectProvider(ethMeta.connector);
      Future.delayed(const Duration(seconds: 1), () async {
        await launchUrl(
          Uri.parse(ethMeta.uri),
        );
      });
      final message = await API.getToken();
      final signedBytes = await provider.personalSign(
        message: message,
        address: ethMeta.address,
        password: '',
      );
      //Getting the verified message

      final verifiedMessage =
          await API.getVerifiedToken(ethMeta.address, signedBytes);
      if (verifiedMessage == "Token verified") {
        await ethMeta.connector.killSession();
        return await API.metamaskLogin(ethMeta.address);
      }
      return Future.value(false);
      // connector.killSession();
    } catch (e) {
      print('===ethereumSign ERROR===  ' + e.toString().substring(60));
      showCustomSnackBar(text: e.toString().substring(60), color: kColorDanger);
      return Future.value(false);
    }
  }
}
