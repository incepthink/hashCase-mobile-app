import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hash_case/pages/login.dart';

import '../GlobalConstants.dart';

class GalleryPage extends StatelessWidget {
  GalleryPage({Key? key}) : super(key: key);
  final List<String> _listFilters = [
    'Popular',
    'Latest',
    'Sneakers',
    '3D',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginPage())),
            child: Text(
              'Catalogue',
              style: kTextStyleArcadeClassic.copyWith(fontSize: 32),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              border: Border.all(width: 1.5, color: Colors.white54),
            ),
            child: TextField(
              style: kTextStyleBody,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(maxHeight: 24),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
              ),
              cursorColor: Colors.white70,
            ),
          ),
          SizedBox(
            height: 20,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 25),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  _listFilters[index],
                  style: kTextStyleBody2,
                );
              },
              itemCount: _listFilters.length,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                itemCount: 10,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          border: Border.all(width: 1.5, color: Colors.white54),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/avatars/avatar${index % 2 + 1}.png',
                                  height: 200,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              '#1178 Bobble Headz',
                              style: kTextStyleH1,
                            ),
                            Row(
                              children: const [
                                Text(
                                  'BobbleHeadz',
                                  style: kTextStyleSecondary,
                                ),
                                Icon(
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
                                        return const ProductInfoBuilder();
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.5, color: Colors.white54),
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
                                    style: kTextStyleBody2.copyWith(
                                        color: Colors.white54),
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
                  );
                }),
          )
        ],
      ),
    );
  }
}

class ProductInfoBuilder extends StatelessWidget {
  const ProductInfoBuilder({
    Key? key,
  }) : super(key: key);

  final String bodyText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris et ex sed ipsum hendrerit posuere semper eu dolor. Vestibulum dapibus metus lectus, vitae ornare tellus commodo ac.';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(35),
        topRight: Radius.circular(35),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 300.0, sigmaY: 300.0),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    const Color(0xff282828).withOpacity(0.5),
                    BlendMode.srcOver),
                child: Container(
                  height: 500,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/vectors/background.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    const Text(
                      '#1178 BobbleHeadz',
                      style: kTextStyleH1,
                    ),
                    SvgPicture.asset('assets/icons/bookmark_filled.svg')
                  ],
                ),
                Image.asset(
                  'assets/avatars/avatar3.png',
                  height: 200,
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
                  height: 10,
                ),
                Text(
                  bodyText,
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
