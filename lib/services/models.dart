import 'package:walletconnect_dart/walletconnect_dart.dart';

class EthereumMetadata {
  String address, uri;
  WalletConnect connector;

  EthereumMetadata({
    required this.address,
    required this.uri,
    required this.connector,
  });
}
