import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hash_case/pages/home.dart';
import 'package:hash_case/pages/signin.dart';
import 'package:hash_case/pages/signup.dart';
import 'package:hash_case/services/api.dart';
import 'package:hash_case/services/storageService.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:public_address_wallet/public_address_wallet.dart';

class MetamaskSignIn extends StatefulWidget {
  const MetamaskSignIn({Key? key}) : super(key: key);

  @override
  State<MetamaskSignIn> createState() => _MetamaskSignInState();
}

class _MetamaskSignInState extends State<MetamaskSignIn> {
  @override
  Widget build(BuildContext context) {
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

    startConnect(Wallet wallet) async {
      try {
        final connector = WalletConnector(
            AppInfo(name: "Mobile App", url: "https://example.mobile.com"));
        String address = await connector
            .publicAddress(wallet: wallet)
            .catchError((onError) {});
        await StorageService()
            .addressStorage
            .write(key: 'wallet_address', value: address);

         

        // final dynamic portfolio = await API()
        //     .postMetamaskID("0x9c5083dd4838e120dbeac44c052179692aa5dac5");
        print("first address $address");
        API().metamaskLogin(address);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => const HomePage())));
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: ((context) => const HomePage())))

        return address;
      } catch (e) {
        throw Future.error(e);
      }
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
                  startConnect(Wallet.metamask);
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
