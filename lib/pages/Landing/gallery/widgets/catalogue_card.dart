import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../GlobalConstants.dart';
import '../../../../GlobalWidgets/product_info.dart';
import '../../../../HiveDB/NFT/Catalogue.dart';

class CatalogueCard extends StatelessWidget {
  const CatalogueCard({
    Key? key,
    required this.hcNFT,
  }) : super(key: key);
  final Catalogue hcNFT;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                border: Border.all(width: 1.5, color: Colors.white54),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.network(
                      //   hcNFT.image,
                      //   height: 200,
                      // ),
                      Image.asset(
                        'assets/avatars/avatar1.png',
                        height: 200,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    hcNFT.name,
                    style: kTextStyleH1,
                  ),
                  Row(
                    children: [
                      Text(
                        hcNFT.contractAddress.substring(0, 6) +
                            "...." +
                            hcNFT.contractAddress
                                .substring(hcNFT.contractAddress.length - 4),
                        style: kTextStyleSecondary,
                      ),
                      // Text(
                      //   'BobbleHeadz',
                      //   style: kTextStyleSecondary,
                      // ),
                      const Icon(
                        Icons.verified,
                        color: Colors.greenAccent,
                        size: 12,
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            enableDrag: true,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return ProductInfoBuilder(
                                title: hcNFT.name,
                                imageUrl: hcNFT.image,
                                description: hcNFT.toString(),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1.5, color: Colors.white54),
                          ),
                          child: const Text(
                            'Details',
                            style: kTextStyleBody2,
                          ),
                        ),
                      ),
                      Row(children: [
                        Text(
                          '68',
                          style:
                              kTextStyleBody2.copyWith(color: Colors.white54),
                        ),
                        const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                        )
                      ])
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
