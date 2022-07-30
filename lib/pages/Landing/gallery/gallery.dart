import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hash_case/pages/Landing/gallery/widgets/catalogue_card.dart';
import 'package:hash_case/services/smartContractFunctions.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../GlobalConstants.dart';
import '../../../HiveDB/NFT/Catalogue.dart';
import '../../../services/api.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final searchController = TextEditingController();
  final globalBox = Hive.box('globalBox');
  final catalogueBox = Hive.box<Catalogue>('catalogueNFT');
  final List<String> _listFilters = [
    'Popular',
    'Latest',
    'Sneakers',
    '3D',
  ];

  @override
  void initState() {
    super.initState();
    API.getCollections();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScroller) => [
        SliverAppBar(
          flexibleSpace: ClipRRect(
            child: Container(
              height: MediaQueryData.fromWindow(ui.window).viewPadding.top,
            ),
          ),
          backgroundColor: Colors.transparent,
          floating: true,
          leading: const SizedBox(),
          shadowColor: Colors.transparent,
          title: InkWell(
            onTap: () async {
              SmartContractFunction.smartContracts();
            },
            child: Text(
              'Catalogue',
              style: kTextStyleArcadeClassic.copyWith(fontSize: 32),
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(117),
            child: ClipRRect(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.white54),
                      ),
                      child: TextFormField(
                        style: kTextStyleBody,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SvgPicture.asset(
                              'assets/icons/search.svg',
                            ),
                          ),
                          prefixIconConstraints:
                              const BoxConstraints(maxHeight: 24),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        cursorColor: Colors.white70,
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 25),
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
                  ],
                ),
              ),
            ),
          ),
        )
      ],
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: ValueListenableBuilder(
                valueListenable: catalogueBox.listenable(),
                builder: (context, Box<Catalogue> box, _) {
                  List<Catalogue> displayList = box.values.toList();
                  if (displayList.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return CatalogueCard(
                          hcNFT: displayList[index],
                        );
                      },
                      childCount: displayList.length,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
