import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hash_case/HiveDB/UserData/UserData.dart';
import 'package:hash_case/services/api.dart';
import 'package:hash_case/services/smartContractFunctions.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../GlobalConstants.dart';

class ProductInfoBuilder extends StatelessWidget {
  const ProductInfoBuilder(
      {Key? key,
      this.imageUrl,
      required this.title,
      required this.description,
      required this.onPop,
      this.boldText = '',
      this.contractAddress = '',
      this.type = false,
      this.nft,
      this.id})
      : super(key: key);
  final String description;
  final String? imageUrl;
  final VoidCallback onPop;
  final String boldText;
  final String title;
  final String contractAddress;
  final bool type;
  final id;
  final nft;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0x3300C2FF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 6,
                    margin: const EdgeInsets.only(bottom: 20),
                    width: size.width * 0.25,
                    decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: onPop,
                      child: SvgPicture.asset('assets/icons/arrow.svg')),
                  Text(
                    title,
                    style: kTextStyleH1,
                  ),
                  SvgPicture.asset('assets/icons/bookmark_filled.svg')
                ],
              ),
              const SizedBox(height: 20),
              if (["", '-', null].contains(imageUrl))
                Image.asset(
                  'assets/avatars/avatar3.png',
                  height: 200,
                ),
              if (!["", '-', null].contains(imageUrl))
                CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.fitHeight,
                  height: 200,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              const SizedBox(height: 20),
              (!type)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.star_half_rounded,
                              color: Colors.yellowAccent,
                            ),
                            Text(
                              '4.5',
                              style: kTextStyleBody2,
                            )
                          ],
                        ),
                        Text(
                          boldText,
                          style: kTextStyleH1,
                        )
                      ],
                    )
                  : FutureBuilder(
                      future: SmartContractFunction()
                          .balanceOfNFT(contractAddress, id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            'Quantity: ${snapshot.data}',
                            style: kTextStyleBody2,
                          );
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        return const SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(child: CircularProgressIndicator()));
                      }),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: kTextStyleSecondary,
                ),
              ),
              if (!type)
                InkWell(
                  onTap: () async {
                    print(nft.merchandise.id);
                    await API.claimToWallet(nft.merchandise.id);
                    final globalBox = Hive.box('globalBox');
                    final UserData userData = globalBox.get('userData');
                    var localNFTs = userData.localNFTs;
                    localNFTs.remove(nft);
                    userData.localNFTs = localNFTs;

                    // await API.fetchEmailNFTs();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: kGradientG1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/cart.svg'),
                        const SizedBox(width: 10),
                        const Text(
                          'Buy Now',
                          style: kTextStyleH2,
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
