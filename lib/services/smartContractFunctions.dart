import 'package:flutter/services.dart';
import 'package:hash_case/HiveDB/UserData/UserData.dart';
import 'package:hash_case/services/api.dart';
import 'package:hash_case/services/storageService.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class SmartContractFunction {
  static Future smartContracts() async {
    // print('this is smartontract');
    String abiStringFile =
        await rootBundle.loadString("SmartContract/nft_apparel_v2.abi.json");
    // print(abiStringFile);
    final serverSideProps = await API.getServerSideProps();
    final nftList = [];

    for (var i in serverSideProps) {
      final contractString = i['contract_address'];
      final contractAddr = EthereumAddress.fromHex(contractString);

      final contract = DeployedContract(
          ContractAbi.fromJson(abiStringFile, 'NftApparel'), contractAddr);
      // print(contract);
      final tokensOfOwner = contract.function('tokensOfOwner');
      var httpClient = Client();
      var ethClient = Web3Client('https://polygon-rpc.com', httpClient);
      // var credentials = EthPrivateKey.fromHex(
      //     "a3d250b1bc16bf44243310d3ecc59c8d6f77e05db5fc988eb000bb3d6b94ea81");
      // var address = await StorageService.JWTStorage.read(key: 'wallet_address');
      final UserData userData = await Hive.box('globalBox').get('userData');
      final address = userData.walletAddress;
      // var address = await credentials.extractAddress();
      var tokens = await ethClient
          .call(contract: contract, function: tokensOfOwner, params: [
        EthereumAddress.fromHex(address!)
        // address
      ]);
      var contractId = i['id'];
      var mappedToken = tokens[0]
          .map((e) => {'contract_id': contractId.toInt(), 'id': e.toInt()})
          .toList();
      nftList.addAll(mappedToken);
    }
    return nftList;
  }

  static Future balanceOfNFT(var contractAddr, var nftId) async {
    String abiStringFile =
        await rootBundle.loadString("SmartContract/nft_apparel_v2.abi.json");
    final contract = DeployedContract(
        ContractAbi.fromJson(abiStringFile, 'NftApparel'), contractAddr);
    // print(contract);
    final balanceOfNFT = contract.function('balanceOf');
    var httpClient = Client();
    var ethClient = Web3Client('https://polygon-rpc.com', httpClient);
    final UserData userData = await Hive.box('globalBox').get('userData');
    final address = userData.walletAddress;
    // var address = await credentials.extractAddress();
    var balance = await ethClient
        .call(contract: contract, function: balanceOfNFT, params: [
      EthereumAddress.fromHex(address!),
      nftId
    ]);
    return balance;
  }
}
