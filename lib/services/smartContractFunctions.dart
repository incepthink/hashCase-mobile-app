import 'package:flutter/services.dart';
import 'package:hash_case/services/api.dart';
import 'package:hash_case/services/storageService.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class SmartContractFunction {
  Future smartContracts() async {
    String abiStringFile =
        await rootBundle.loadString("SmartContract/nft_apparel_v2.abi.json");
    // print(abiStringFile);
    final contractString =
        (await API().getServerSideProps())['contract_address'];
    final contractAddr = EthereumAddress.fromHex(contractString);

    final contract = DeployedContract(
        ContractAbi.fromJson(abiStringFile, 'NftApparel'), contractAddr);
    // print(contract);
    final tokensOfOwner = contract.function('tokensOfOwner');
    var httpClient = Client();
    var ethClient = Web3Client('https://polygon-rpc.com', httpClient);
    var credentials = EthPrivateKey.fromHex(
        "a3d250b1bc16bf44243310d3ecc59c8d6f77e05db5fc988eb000bb3d6b94ea81");
    // var address = await StorageService().addressStorage.read(key: 'wallet_address');
    var address = await credentials.extractAddress();
    var tokens = await ethClient
        .call(contract: contract, function: tokensOfOwner, params: [
      // EthereumAddress.fromHex('0x6aa93c6c9cb7adccfbef84a91a29d3be5379f72e')
      address
    ]);
    var contractId = (await API().getServerSideProps())['id'];
    var mappedToken = tokens[0]
        .map((e) => {'contract_id': contractId.toInt(), 'id': e.toInt()})
        .toList();
    return mappedToken;
    // var walletNFTs = await API().onWalletNfts(mappedToken);
  }
}
