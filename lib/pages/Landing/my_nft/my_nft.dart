import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hash_case/pages/Landing/my_nft/widgets/nft_card.dart';

import '../../../GlobalConstants.dart';
import '../../../HiveDB/UserData/UserData.dart';
import '../../../services/api.dart';

class MyNFTs extends StatefulWidget {
  const MyNFTs({Key? key}) : super(key: key);
  @override
  State<MyNFTs> createState() => _MyNFTsState();
}

class _MyNFTsState extends State<MyNFTs> {
  final globalBox = Hive.box('globalBox');
  final ValueNotifier isLoading = ValueNotifier(true);
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    isLoading.value = true;
    await API.fetchEmailNFTs();
    await API.fetchWalletNfts();
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          30, MediaQuery.of(context).padding.top + 15, 30, 0),
      child: Column(
        children: [
          Text(
            'MY NFTs',
            style: kTextStyleArcadeClassic.copyWith(fontSize: 32),
          ),
          ValueListenableBuilder(
            valueListenable: globalBox.listenable(keys: ['userData']),
            builder: (context, Box<dynamic> box, value) {
              UserData? userData = box.get('userData', defaultValue: null);
              final myNFTList = userData == null ? [] : userData.myNFTList;
              if (userData == null) {}
              if (myNFTList.isEmpty) {
                return ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder: (context, value, child) {
                    if (isLoading.value) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: SizedBox(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                          height: 30,
                          width: 30,
                        ),
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.only(top: 50),
                      child: const Text(
                        'No NFTs to display',
                        style: kTextStyleBody,
                      ),
                    );
                  },
                );
              }
              return Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 30,
                    childAspectRatio: 1 / 1.4,
                  ),
                  itemBuilder: (context, index) {
                    return NFTCard(nft: myNFTList[index]);
                  },
                  itemCount: myNFTList.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
