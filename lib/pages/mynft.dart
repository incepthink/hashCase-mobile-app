import 'dart:ui';

import 'package:flutter/material.dart';

import '../GlobalConstants.dart';
import 'gallery.dart';

class MyNFTs extends StatelessWidget {
  const MyNFTs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
      child: Column(
        children: [
          Text(
            'MY NFTs',
            style: kTextStyleArcadeClassic.copyWith(fontSize: 32),
          ),
          Expanded(
            child: GridView(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 3 / 4),
              children: [
                for (int i = 0; i <= 10; i++)
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        enableDrag: true,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return const ProductInfoBuilder();
                        },
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/vectors/mynft${i % 4 + 1}.png'),
                        ClipRRect(
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5,
                                    color: const Color(0xffFEFEFE)
                                        .withOpacity(0.5)),
                                color: Colors.black.withOpacity(0.2),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0x73FFFFFF),
                                    Color(0x26FFFFFF),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Super Influencers',
                                      style: kTextStyleBody2,
                                    ),
                                    const SizedBox(height: 7),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          '#1267',
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
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
