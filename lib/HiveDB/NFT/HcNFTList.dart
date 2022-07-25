import 'package:hive/hive.dart';

import '../../GlobalConstants.dart' as gc;
import 'HcNFT.dart';
part 'HcNFTList.g.dart';

@HiveType(typeId: gc.kHcNFTList)
class HcNFTList extends HiveObject {
  @HiveField(0)
  List<HcNFT> hcNFTList;

  HcNFTList({required this.hcNFTList});
}
