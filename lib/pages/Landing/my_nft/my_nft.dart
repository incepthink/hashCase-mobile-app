import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hash_case/pages/Landing/my_nft/widgets/nft_card.dart';

import '../../../GlobalConstants.dart';
import '../../../GlobalWidgets/tab_view.dart';
import '../../../HiveDB/UserData/UserData.dart';
import '../../../services/api.dart';

class MyNFTs extends StatefulWidget {
  const MyNFTs({Key? key, required this.pageController}) : super(key: key);
  @override
  State<MyNFTs> createState() => _MyNFTsState();
  final PageController pageController;
}

class _MyNFTsState extends State<MyNFTs> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = <String>[
    'OnChain',
    'Local',
  ];
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (OverscrollNotification overscroll) {
        if (overscroll.overscroll < 0 &&
            overscroll.dragDetails != null &&
            overscroll.dragDetails!.delta.dx > 15) {
          widget.pageController.animateTo(
            0,
            curve: Curves.ease,
            duration: const Duration(milliseconds: 250),
          );
        }
        if (overscroll.overscroll > 0 &&
            overscroll.dragDetails != null &&
            overscroll.dragDetails!.delta.dx < -15) {
          widget.pageController.animateTo(
            2,
            curve: Curves.ease,
            duration: const Duration(milliseconds: 250),
          );
        }
        return true;
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            30, MediaQuery.of(context).padding.top + 15, 30, 0),
        child: Column(
          children: [
            const Text(
              'MY NFTS',
              style: kTextStyleGotham,
            ),
            TabView(
              tabController: _tabController,
              tabs: tabs,
            ),
            Expanded(
              child: TabBarView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                controller: _tabController,
                children: const [
                  NFTsBuilder(onChain: true),
                  NFTsBuilder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NFTsBuilder extends StatefulWidget {
  const NFTsBuilder({
    Key? key,
    this.onChain = false,
  }) : super(key: key);
  final bool onChain;
  @override
  State<NFTsBuilder> createState() => _NFTsBuilderState();
}

class _NFTsBuilderState extends State<NFTsBuilder> {
  final globalBox = Hive.box('globalBox');
  final ValueNotifier<bool> isLoading = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    isLoading.value = true;
    if (widget.onChain) {
      await API.fetchWalletNFTs();
    } else {
      await API.fetchEmailNFTs();
    }
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: globalBox.listenable(keys: ['userData']),
      builder: (context, Box<dynamic> box, value) {
        UserData? userData = box.get('userData', defaultValue: null);
        final myNFTList = userData == null
            ? []
            : widget.onChain
                ? userData.onChainNFTs
                : userData.localNFTs;
        if (userData == null) {
          return const SizedBox();
        }
        if (myNFTList.isEmpty) {
          return ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, bool loading, child) {
              if (loading) {
                return Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: SizedBox(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                );
              }
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'No NFTs to display',
                  textAlign: TextAlign.center,
                  style: kTextStyleBody,
                ),
              );
            },
          );
        }
        return GridView.builder(
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
        );
      },
    );
  }
}
