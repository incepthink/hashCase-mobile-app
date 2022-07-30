import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../GlobalConstants.dart';

class ProductInfoBuilder extends StatelessWidget {
  const ProductInfoBuilder({
    Key? key,
    this.imageUrl,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String description;
  final String? imageUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(35),
        topRight: Radius.circular(35),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 300.0, sigmaY: 300.0),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    const Color(0xff282828).withOpacity(0.5),
                    BlendMode.srcOver),
                child: Container(
                  height: 600,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            child: SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Container(
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    width: size.width * 0.4,
                    decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('assets/icons/arrow.svg'),
                      Text(
                        title,
                        style: kTextStyleH1,
                      ),
                      SvgPicture.asset('assets/icons/bookmark_filled.svg')
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                const SizedBox(height: 20),
                Row(
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
                    const Text(
                      '0.05 ETH',
                      style: kTextStyleH1,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  description,
                  style: kTextStyleSecondary,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
