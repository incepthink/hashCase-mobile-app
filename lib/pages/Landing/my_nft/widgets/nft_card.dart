import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../GlobalConstants.dart';
import '../../../../GlobalWidgets/product_info.dart';
import '../../../../HiveDB/NFT/NFT.dart';

class NFTCard extends StatelessWidget {
  const NFTCard({Key? key, required this.nft}) : super(key: key);

  final NFT nft;

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
              onPop: Navigator.of(context).pop,
              title: nft.merchandise.name,
              imageUrl: nft.merchandise.imageURL,
              description: nft.merchandise.description,
              boldText: 'ID: ${nft.merchandise.id}',
            );
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: nft.merchandise.imageURL,
              fit: BoxFit.fitHeight,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          // Expanded(
          //   child: Image.network(
          //     nft.merchandise.imageURL,
          //     fit: BoxFit.fitHeight,
          //     loadingBuilder: (BuildContext context, Widget child,
          //         ImageChunkEvent? loadingProgress) {
          //       if (loadingProgress == null) return child;
          //       return Center(
          //         child: CircularProgressIndicator(
          //           value: loadingProgress.expectedTotalBytes != null
          //               ? loadingProgress.cumulativeBytesLoaded /
          //                   loadingProgress.expectedTotalBytes!
          //               : null,
          //           color: Colors.white,
          //           strokeWidth: 3,
          //         ),
          //       );
          //     },
          //   ),
          // ),
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
                        overflow: TextOverflow.ellipsis,
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
                            nft.merchandise.claimable ? "Claimable" : "Claimed",
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
