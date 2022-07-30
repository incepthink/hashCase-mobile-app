import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hash_case/pages/Archived/signup.dart';
import 'package:hash_case/services/api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
// import 'package:public_address_wallet/public_address_wallet.dart';
import 'package:web3dart/web3dart.dart';

import 'signin.dart';

const String rpcUrl = 'http://localhost:7545';
const String wsUrl = 'ws://localhost:7545';

class MetamaskSignIn extends StatefulWidget {
  const MetamaskSignIn({Key? key}) : super(key: key);

  @override
  State<MetamaskSignIn> createState() => _MetamaskSignInState();
}

// Future<String> call1({
//   EthereumAddress? sender,
//   required WalletConnect connector,
//   required DeployedContract contract,
//   required ContractFunction function,
//   required List<dynamic> params,
// }) async {
//   final result = await connector.sendCustomRequest(
//     method: 'eth_call',
//     params: [contract.address.hex, function.encodeCall(params)],
//   );

//   return result;
// }

_smartContracts() async {
  String abiStringFile =
      await rootBundle.loadString("SmartContract/nft_apparel_v2.abi.json");
  // print(abiStringFile);
  final contractString = (await API.getServerSideProps())['contract_address'];
  final contractAddr = EthereumAddress.fromHex(contractString);

  final contract = DeployedContract(
      ContractAbi.fromJson(abiStringFile, 'NftApparel'), contractAddr);
  // print(contract);
  final tokensOfOwner = contract.function('tokensOfOwner');
  var httpClient = Client();
  var ethClient = Web3Client('https://polygon-rpc.com', httpClient);
  var credentials = EthPrivateKey.fromHex(
      "a3d250b1bc16bf44243310d3ecc59c8d6f77e05db5fc988eb000bb3d6b94ea81");
  var address = await credentials.extractAddress();
  var tokens = await ethClient
      .call(contract: contract, function: tokensOfOwner, params: [
    // EthereumAddress.fromHex('0x6aa93c6c9cb7adccfbef84a91a29d3be5379f72e')
    address
  ]);

  print('testing--${tokens}');
  var contractId = (await API.getServerSideProps())['id'];
  print(contractId);
  var mappedToken = tokens[0]
      .map((e) => {'contract_id': contractId.toInt(), 'id': e.toInt()})
      .toList();
  print(mappedToken);

  // var walletNFTs = await API.fetchWalletNfts();
}

class _MetamaskSignInState extends State<MetamaskSignIn> {
  @override
  Widget build(BuildContext context) {
    // var _uri;
    // Future signIn() async {
    // final connector = WalletConnect(
    //   bridge: 'https://bridge.walletconnect.org',
    //   clientMeta: const PeerMeta(
    //     name: 'WalletConnect',
    //     description: 'WalletConnect Developer App',
    //     url: 'https://walletconnect.org',
    //     icons: [
    //       'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
    //     ],
    //   ),
    // );
    // if (!connector.connected) {
    //   final session = await connector.createSession(
    //     chainId: 4160,
    //     onDisplayUri: (uri) => launchUrl(
    //       Uri.parse(uri),
    //     ),
    //   );
    // }
    // var message = API().getToken();
    // var address = connector.sessionStorage!.getSession();
    // print(address);
    // final sender = Address.fromAlgorandAddress(address: session.accounts[0]);
    // final sender = Address.fromEthereumAddress(address: session.accounts[0]);
    // connector.setDefaultProvider(AlgorandWCProvider(connector));
    // final signedBytes = await connector.signTransaction(
    //   message,
    //   params: {
    //     'message': 'Optional description message',
    //   },
    // );

    // connector.on(
    //     'connect',
    //     (session) => Navigator.of(context)
    //         .push(MaterialPageRoute(builder: ((context) => const HomePage())))
    //     // Navigator.of(context).push(
    //     //     MaterialPageRoute(builder: ((context) => const HomePage())))
    //     );
    // connector.on(
    //     'session_update',
    //     (payload) => Navigator.of(context).push(
    //         MaterialPageRoute(builder: ((context) => const HomePage()))));
    // }
    Uri metamaskDownloadLink = Uri.parse("https://metamask.io/download/");
    void _launchUrl() async {
      if (!await launchUrl(
        metamaskDownloadLink,
        mode: LaunchMode.externalApplication,
      )) {
        throw 'Could not launch $metamaskDownloadLink';
      }
    }

    // ethereumConnect() async {
    //   final connector = WalletConnect(
    //     bridge: 'https://bridge.walletconnect.org',
    //     clientMeta: const PeerMeta(
    //       name: 'WalletConnect',
    //       description: 'WalletConnect Developer App',
    //       url: 'https://walletconnect.org',
    //       icons: [
    //         'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
    //       ],
    //     ),
    //   );
    //   if (!connector.connected) {
    //     final session = await connector.createSession(
    //         chainId: 4160,
    //         onDisplayUri: (uri) {
    //           _uri = uri;
    //           launchUrl(
    //             Uri.parse(uri),
    //           );
    //         });
    //   }
    //
    //   // signTranaction
    //   final provider = EthereumWalletConnectProvider(connector);
    //   var ses = connector.session.accounts[0];
    //   await StorageService.JWTStorage.write(key: 'wallet_address', value: ses);
    //   launchUrl(
    //     Uri.parse(_uri),
    //   );
    //   final message = await API.getToken();
    //   final signedBytes = await provider.personalSign(
    //     message: message,
    //     address: ses,
    //     password: '',
    //   );
    //   //Getting the verified message
    //
    //   final verifiedMessage = await API.getVerifiedToken(ses, signedBytes);
    //   if (verifiedMessage == "Token verified") {
    //     await API.metamaskLogin(ses);
    //   }
    //
    //   //kil session
    //   connector.killSession();
    // }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.all(Radius.circular(60)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                try {
                  // _launchUrl();
                  // ethereumConnect();
                  _smartContracts();
                  // startConnect(Wallet.metamask);
                } catch (e) {
                  _launchUrl();
                }
                // signIn();
                // API().getToken();
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text('LogIn with Metamask',
                        style: TextStyle(fontSize: 25, color: Colors.black)),
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                // API().SignIN('anishsreenivas86@gmail.com', 'test@123');
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => const SignIn())));
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text('LogIn with Email',
                        style: TextStyle(fontSize: 25, color: Colors.black)),
                  )),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New User?'),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const SignUp())));
                    },
                    child: const Text(' Sign UP'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
