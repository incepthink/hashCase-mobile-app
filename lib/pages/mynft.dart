import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../GlobalConstants.dart';
import '../HiveDB/NFT/NFT2.dart';
import '../HiveDB/UserData/UserData.dart';
import '../services/api.dart';
import 'gallery.dart';

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
    await API().fetchLocalNfts();
    await API().onWalletNfts();
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(30, MediaQuery.of(context).padding.top, 30, 0),
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
                    mainAxisSpacing: 5,
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

class NFTCard extends StatelessWidget {
  const NFTCard({Key? key, required this.nft}) : super(key: key);

  final NFT2 nft;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return ProductInfoBuilder(
              title: nft.merchandise.name,
              imageUrl: nft.merchandise.imageURL,
              description: nft.toString(),
            );
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.network(
              nft.merchandise.imageURL,
              fit: BoxFit.fitHeight,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                );
              },
            ),
          ),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.5,
                      color: const Color(0xffFEFEFE).withOpacity(0.5)),
                  color: Colors.black.withOpacity(0.2),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0x73FFFFFF),
                      Color(0x26FFFFFF),
                    ],
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nft.merchandise.name,
                        style: kTextStyleBody2,
                      ),
                      const SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            nft.merchandise.id.toString(),
                            style: kTextStyleSecondary,
                          ),
                          Text(
                            'ETH 6.64',
                            style: kTextStyleSecondary.copyWith(
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
