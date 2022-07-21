import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hash_case/pages/home.dart';
import 'package:hash_case/pages/signin.dart';
import 'package:hash_case/pages/signup.dart';
import 'package:hash_case/services/api.dart';
import 'package:hash_case/services/storageService.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' show join, dirname;
import 'package:walletconnect_dart/walletconnect_dart.dart';
// import 'package:public_address_wallet/public_address_wallet.dart';
import 'package:web3dart/web3dart.dart';

class MetamaskSignIn extends StatefulWidget {
  const MetamaskSignIn({Key? key}) : super(key: key);

  @override
  State<MetamaskSignIn> createState() => _MetamaskSignInState();
}

_smartContracts() async {
  // final File abiFile = File(join(
  //     dirname(Platform.script.path), 'SmartContract/nft_apparel_v2.abi.json'));

  // print(abiFile.path.toString());
  String abiStringFile =
      await rootBundle.loadString("SmartContract/nft_apparel_v2.abi.json");
  // print(abiStringFile);
  final contractAddr =
      EthereumAddress.fromHex(await API().getServerSideProps());

  final contract = DeployedContract(
      ContractAbi.fromJson(abiStringFile, 'MetaCoin'), contractAddr);
  print(contract);
  // var jsonAbi = jsonDecode(abiStringFile);
  // print(jsonAbi);
  // final abiCode = await abiFile.readAsString();
  // API().getServerSideProps();
//   final contract =
//       DeployedContract(ContractAbi.fromJson(abiCode, 'MetaCoin'), contractAddr);
}

jsonDecode(String abiStringFile) {}

class _MetamaskSignInState extends State<MetamaskSignIn> {
  @override
  Widget build(BuildContext context) {
    var _uri;
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

//     startConnect(Wallet wallet) async {
//       try {
//         final connector = WalletConnector(
//             AppInfo(name: "Mobile App", url: "https://example.mobile.com"));
//         String address = await connector
//             .publicAddress(wallet: wallet)
//             .catchError((onError) {});
//         await StorageService()
//             .addressStorage
//             .write(key: 'wallet_address', value: address);
//         print("first address $address");
//         API().metamaskLogin(address);

//          final connector1 = WalletConnect(
//           bridge: 'https://bridge.walletconnect.org',
//           clientMeta:const PeerMeta(
//             name: 'WalletConnect',
//             description: 'WalletConnect Developer App',
//             url: 'https://walletconnect.org',
//             icons: [
//               'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
//             ],
//           ),
//         );
//         final provider = EthereumWalletConnectProvider(connector1);
//          final sender = EthereumAddress.fromHex(session.accounts[0]);
// //  final sender =Address.fromAlgorandAddress(address: session.accounts[0]);

//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: ((context) => const HomePage())));
//         // Navigator.of(context).push(
//         //     MaterialPageRoute(builder: ((context) => const HomePage())))

//         return address;
//       } catch (e) {
//         throw Future.error(e);
//       }
//     }

    // Future<String> signTransaction(SessionStatus session) async {
    //   final sender = EthereumAddress.fromHex(session.accounts[0]);
    //   return sender.toString();
    // }

    ethereumConnect() async {
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
      if (!connector.connected) {
        final session = await connector.createSession(
            chainId: 4160,
            onDisplayUri: (uri) {
              _uri = uri;
              launchUrl(
                Uri.parse(uri),
              );
            });
      }

      final provider = EthereumWalletConnectProvider(connector);
      var ses = connector.session.accounts[0];
      print(ses);

      final sender = EthereumAddress.fromHex(ses);
      launchUrl(
        Uri.parse(_uri),
      );
      final transaction = Transaction(
        to: sender,
        from: sender,
        // gasPrice: EtherAmount.inWei(BigInt.one),
        // maxGas: 100000,
        // value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 1),
      );

      // final credentials = WalletConnectEthereumCredentials(provider: provider);
      // Credentials fromHex = EthPrivateKey.fromHex(
      //     "a3d250b1bc16bf44243310d3ecc59c8d6f77e05db5fc988eb000bb3d6b94ea81");
      // final ethereum = Web3Client(
      //     'https://eth-mainnet.gateway.pokt.network/v1/5f3453978e354ab992c4da79',
      //     Client());
      // final txBytes = await ethereum.signTransaction(fromHex, transaction);
      // print(txBytes);
      final message = await API().getToken();

      final signedBytes = await provider.personalSign(
        message: message, address: ses, password: '',
        // to: sender.toString(),
        // from: sender.toString(),
        // gasPrice: EtherAmount.inWei(BigInt.one),
        // maxGas: 100000,
        // value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 1),
      );
      // print('testing-----$signedBytes');
      print('testHere');
      final verifiedMessage = await API().getVerifiedToken(ses, signedBytes);
      print('verifiedMessage----$verifiedMessage');

      if (verifiedMessage == "Token verified") {
        API().metamaskLogin(ses);
      }

      print('session is getting killed?');
      connector.killSession();

      // Kill the session

      // return txBytes;
      // }
    }

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
